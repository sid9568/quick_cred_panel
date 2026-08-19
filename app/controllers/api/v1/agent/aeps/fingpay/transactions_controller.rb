module Api
  module V1
    module Agent
      module Aeps
        module Fingpay
          class TransactionsController < Api::V1::Auth::BaseController

            require "securerandom"

            def transaction_list
              transactions = AepsTransaction.all.order(created_at: :desc)

              render json: {
                success: true,
                message: "Transaction list fetched successfully",
                data: transactions.as_json(
                  only: [
                    :id,
                    :transaction_type,
                    :client_ref_id,
                    :customer_id,
                    :bank_name,
                    :bank_code,
                    :amount,
                    :commission,
                    :tds,
                    :tx_status,
                    :status,
                    :message,
                    :comment,
                    :tid,
                    :bank_ref_num,
                    :merchant_name,
                    :sender_name,
                    :shop_name,
                    :transaction_date,
                    :opening_balance,
                    :closing_balance,
                    :created_at
                  ]
                )
              }, status: :ok
            end

          def fund_initiate_list
            transactions = AepsWalletTransaction
                             .includes(:user)
                             .where(user_id: current_user.id)
                             .order(created_at: :desc)

            render json: {
              success: true,
              message: "Fund initiate list fetched successfully",
              total_records: transactions.count,
              data: transactions.map do |transaction|
                {
                  id: transaction.id,
                  amount: transaction.amount,
                  transaction_type: transaction.transaction_type,
                  status: transaction.status,
                  remarks: transaction.remarks,
                  reference_id: transaction.reference_id,
                  balance_before: transaction.balance_before,
                  balance_after: transaction.balance_after,
                  created_at: transaction.created_at,

                  user: {
                    id: transaction.user.id,
                    name: transaction.user.first_name,
                    email: transaction.user.email,
                    phone_number: transaction.user.phone_number,
                    user_code: transaction.user.user_code,
                    company_name: transaction.user.company_name
                  }
                }
              end
            }, status: :ok
          end

            def balance_enquiry
              required_params = %i[
                bank_code
                aadhar
                piddata
              ]

              missing_params = required_params.select { |param| params[param].blank? }

              if missing_params.any?
                return render json: {
                  success: false,
                  error: "#{missing_params.join(', ')} is required"
                }, status: :unprocessable_entity
              end

             client_ref_id = "#{Time.current.strftime('%Y%m%d%H%M%S')}#{SecureRandom.random_number(1000..9999)}"

              service = ::Aeps::Fingpay::BalanceEnquiryService.new

              result = service.call(
                initiator_id: current_user.phone_number,
                user_code: current_user.user_code,
                customer_id: current_user.phone_number,
                bank_code: params[:bank_code],
                client_ref_id: client_ref_id,
                aadhar: params[:aadhar],
                piddata: params[:piddata],
                latlong: current_user.aeps_latlong
              )

              if result[:success]
                render json: result[:data], status: :ok
              else
                render json: result, status: :unprocessable_entity
              end
            rescue StandardError => e
              render json: {
                success: false,
                error: e.message
              }, status: :internal_server_error
            end

          def create
            required_params = %i[
              bank_code
              amount
              piddata
              phone_number
              aadhar
            ]

            missing_params = required_params.select { |param| params[param].blank? }

            if missing_params.any?
              return render json: {
                success: false,
                error: "#{missing_params.join(', ')} is required"
              }, status: :unprocessable_entity
            end

            amount = params[:amount].to_d

            client_ref_id = "#{Time.current.strftime('%Y%m%d%H%M%S')}#{SecureRandom.random_number(1000..9999)}"

            response = ::Aeps::Fingpay::TransactionService.new.call(
              service_type: 1,
              initiator_id: "6268075916",
              user_code: current_user.user_code,
              customer_id: current_user.phone_number,
              bank_code: params[:bank_code],
              amount: params[:amount],
              client_ref_id: client_ref_id,
              pipe: "0",
              aadhar: params[:aadhar],
              notify_customer: "1",
              latlong: current_user.aeps_latlong,
              piddata: params[:piddata]
            )

            unless response[:success]
              return render json: response, status: :unprocessable_entity
            end

            api_response = response[:data]

            unless api_response["response_status_id"] == 0
              return render json: {
                success: false,
                message: api_response["message"],
                data: api_response
              }, status: :unprocessable_entity
            end

            transaction = api_response["data"] || {}

            aeps_wallet = AepsWallet.find_or_create_by!(user: current_user) do |wallet|
              wallet.balance = 0
            end

            transaction_date =
              begin
                Time.zone.parse(transaction["transaction_date"])
              rescue StandardError
                nil
              end

            # ================= COMMISSION START =================
           transaction_success = api_response.dig("data", "tx_status") == "0"

            commission_map = {}

            if transaction_success
              slab_range = AepsCommissionSlabRange.where(
                "min_amount <= :amt AND max_amount >= :amt", amt: amount
              ).where(service_type: "transaction").first

              if slab_range.present?
                scheme_id = current_user.scheme_id
                commission_slabs = AepsCommissionSlab.where(
                  aeps_commission_slab_range_id: slab_range.id,
                  scheme_id: scheme_id,
                  service_type: "transaction",
                  active: true
                ).index_by(&:to_role)

                retailer_percent = commission_slabs["retailer"]&.value.to_f
                dealer_percent   = commission_slabs["dealer"]&.value.to_f
                master_percent   = commission_slabs["master"]&.value.to_f

                admin_pool_percent = slab_range.value.to_f
                amount_f           = amount.to_f

                admin_pool_amount = (admin_pool_percent / 100) * amount_f
                retailer_amount   = (retailer_percent / 100) * amount_f
                dealer_amount     = (dealer_percent / 100) * amount_f
                master_amount     = (master_percent / 100) * amount_f

                # ✅ Fallback: agar EKO se commission blank/0 aaye, to admin_pool_amount hi treat karo asli commission
                raw_eko_commission = transaction["commission"].presence || api_response.dig("data", "commission")
                commission_eko = raw_eko_commission.present? ? raw_eko_commission.to_f : admin_pool_amount
                commission_eko = admin_pool_amount if commission_eko <= 0

                distributed_below_admin = master_amount + dealer_amount + retailer_amount
                admin_amount = admin_pool_amount - distributed_below_admin
                admin_amount = 0 if admin_amount.negative?

                superadmin_amount = commission_eko - admin_pool_amount
                superadmin_amount = 0 if superadmin_amount.negative?

                commission_map[:superadmin] = superadmin_amount
                commission_map[:admin]      = admin_amount
                commission_map[:master]     = master_amount
                commission_map[:dealer]     = dealer_amount
                commission_map[:retailer]   = retailer_amount
                commission_map = commission_map.transform_values { |v| v.to_f.round(2) }

                Rails.logger.info "commission_eko used: #{commission_eko}"
                Rails.logger.info "Commission Breakdown: #{commission_map}"

                total_commission = commission_map.values.sum
                if total_commission > commission_eko
                  excess = total_commission - commission_eko
                  commission_map[:retailer] = [commission_map[:retailer] - excess, 0].max
                  Rails.logger.info "Adjusted Commission Breakdown: #{commission_map}"
                end
              end
            end
            # ================= COMMISSION END =================

            aeps_transaction = nil

            ActiveRecord::Base.transaction do
              opening_balance = aeps_wallet.balance
              closing_balance = opening_balance + amount

              if transaction_success
                closing_balance = opening_balance + amount
                aeps_wallet.update!(
                  balance: closing_balance
                )
              end

              aeps_transaction = AepsTransaction.create!(
                user: current_user,
                transaction_type: "cash_withdrawal",
                client_ref_id: client_ref_id,
                customer_id: params[:phone_number],
                user_code: transaction["user_code"],
                bank_code: params[:bank_code],
                bank_name: transaction["bank"],
                aadhaar_number: transaction["aadhar"],
                aadhaar_last4: params[:aadhar].to_s.last(4),
                amount: transaction["amount"],
                customer_balance: transaction["customer_balance"],
                opening_balance: opening_balance,
                closing_balance: closing_balance,
                commission: transaction["commission"],
                tds: transaction["tds"],
                tx_status: transaction["tx_status"],
                status: transaction_success ? "success" : "failed",
                message: api_response["message"],
                comment: transaction["comment"],
                tid: transaction["tid"],
                bank_ref_num: transaction["bank_ref_num"],
                merchant_name: transaction["merchantname"],
                sender_name: transaction["sender_name"],
                shop_name: transaction["shop"],
                transaction_date: transaction_date,
                provider_response: api_response
              )

              # ===== DISTRIBUTE COMMISSION =====
              if commission_map.present?
                hierarchy = current_user.find_hierarchy
                ([current_user] + hierarchy).each do |user|
                  role = user.role.title.downcase.to_sym
                  commission_amount = commission_map[role].to_f
                  next if commission_amount <= 0

                  user_wallet = Wallet.find_by(user_id: user.id)
                  next unless user_wallet

                  credit_result = Wallets::WalletService.update_balance(
                    wallet: user_wallet,
                    amount: commission_amount,
                    transaction_type: "credit",
                    remark: "AEPS Transaction Commission",
                    reference_id: aeps_transaction.id
                  )
                  raise ActiveRecord::Rollback unless credit_result[:success]

                  Rails.logger.info "[Commission] #{role.upcase} (User #{user.id}) credited ₹#{commission_amount.round(2)}"
                end
              end
            end

            render json: {
              success: true,
              message: api_response["message"],
              data: api_response,
              wallet_balance: aeps_wallet.reload.balance,
              commission: commission_map
            }, status: :ok

          rescue StandardError => e
            render json: {
              success: false,
              error: e.message
            }, status: :internal_server_error
          end


            def mini_statement
              required_params = %i[
                bank_code
                aadhar
                piddata
              ]
              missing_params = required_params.select { |param| params[param].blank? }
              if missing_params.any?
                return render json: {
                  success: false,
                  error: "#{missing_params.join(', ')} is required"
                }, status: :unprocessable_entity
              end

              response = ::Aeps::Fingpay::MiniStatementService.new.call(
                customer_id: current_user.phone_number,
                user_code: current_user.user_code,
                bank_code: params[:bank_code],
                aadhar: params[:aadhar],
                piddata: params[:piddata],
                latlong: current_user.aeps_latlong
              )

              unless response[:success]
                return render json: response, status: :unprocessable_entity
              end

              response_data = response[:data] || {}

              p "===========response_data==========="
              p response_data

              # ================= MINI STATEMENT COMMISSION START =================
              commission_map = {}

              transaction_success = response_data["response_status_id"] == 0

              if transaction_success
                slab_range = AepsCommissionSlabRange
                  .where(service_type: "mini_statement")
                  .first

                Rails.logger.info "=========mini_statement slab_range========= #{slab_range.inspect}"

                if slab_range.present?
                  scheme_id = current_user.scheme_id
                  commission_slabs = AepsCommissionSlab.where(
                    aeps_commission_slab_range_id: slab_range.id,
                    scheme_id: scheme_id,
                    service_type: "mini_statement",
                    active: true
                  ).index_by(&:to_role)

                  master_amount = commission_slabs["master"]&.value.to_f
                  dealer_amount = commission_slabs["dealer"]&.value.to_f

                  admin_pool_amount = slab_range.value.to_f

                  distributed_below_admin = master_amount + dealer_amount
                  admin_amount = admin_pool_amount - distributed_below_admin
                  admin_amount = 0 if admin_amount.negative?

                  commission_eko = admin_pool_amount

                  superadmin_amount = commission_eko - admin_pool_amount
                  superadmin_amount = 0 if superadmin_amount.negative?

                  commission_map[:superadmin] = superadmin_amount
                  commission_map[:admin]      = admin_amount
                  commission_map[:master]     = master_amount
                  commission_map[:dealer]     = dealer_amount

                  commission_map = commission_map.transform_values { |v| v.to_f.round(2) }

                  Rails.logger.info "Mini Statement Commission Breakdown: #{commission_map}"

                  total_commission = commission_map.values.sum
                  if total_commission >= commission_eko
                    excess = total_commission - commission_eko
                    commission_map[:admin] = [commission_map[:admin] - excess, 0].max
                    Rails.logger.info "Adjusted Mini Statement Commission Breakdown: #{commission_map}"
                    p "=========================commission_map"
                    p commission_map
                  end
                end
              end
              # ================= MINI STATEMENT COMMISSION END =================

              mini_statement_record = nil

              ActiveRecord::Base.transaction do
                # ✅ Record save — sirf success case (yahan tak pahunchna hi success confirm karta hai)
                mini_statement_record = AepsMiniStatement.create!(
                  user: current_user,
                  bank_code: params[:bank_code],
                  customer_id: current_user.phone_number,
                  aadhaar_last4: params[:aadhar].to_s.last(4),
                  status: "success",
                  commission_data: commission_map,
                  provider_response: response_data
                )

                # ✅ Distribute commission
                if commission_map.present?
                  hierarchy = current_user.find_hierarchy
                  ([current_user] + hierarchy).each do |user|
                    role = user.role.title.downcase.to_sym
                    commission_amount = commission_map[role].to_f
                    next if commission_amount <= 0

                    user_wallet = Wallet.find_by(user_id: user.id)
                    next unless user_wallet

                    credit_result = Wallets::WalletService.update_balance(
                      wallet: user_wallet,
                      amount: commission_amount,
                      transaction_type: "credit",
                      remark: "AEPS Mini Statement Commission",
                      reference_id: mini_statement_record.id
                    )
                    raise ActiveRecord::Rollback unless credit_result[:success]

                    Rails.logger.info "[Mini Statement Commission] #{role.upcase} (User #{user.id}) credited ₹#{commission_amount.round(2)}"
                  end
                end
              end

              render json: response_data.merge(commission: commission_map), status: :ok

            rescue StandardError => e
              render json: {
                success: false,
                error: e.message
              }, status: :internal_server_error
            end
            

          end
        end
      end
    end
  end
end