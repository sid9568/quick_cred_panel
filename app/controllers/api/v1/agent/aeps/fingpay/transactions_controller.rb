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
              wallet = current_user.wallet

              # Check wallet balance
              if wallet.blank? || wallet.balance.to_d < amount
                return render json: {
                  success: false,
                  error: "Balance is low",
                  current_balance: wallet&.balance.to_d || 0,
                  requested_amount: amount
                }, status: :unprocessable_entity
              end

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

              unless response[:success]
                return render json: response, status: :unprocessable_entity
              end

              api_response = response[:data]

              # Wallet deduction tabhi hoga jab API success ho
              unless api_response["response_status_id"] == 0
                return render json: {
                  success: false,
                  message: api_response["message"],
                  data: api_response
                }, status: :unprocessable_entity
              end

              transaction = api_response["data"] || {}

              transaction_date =
                begin
                  Time.zone.parse(transaction["transaction_date"])
                rescue StandardError
                  nil
                end

              ActiveRecord::Base.transaction do
                opening_balance = wallet.balance

                wallet.update!(
                  balance: opening_balance - amount
                )

                AepsTransaction.create!(
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
                  closing_balance: wallet.reload.balance,
                  commission: transaction["commission"],
                  tds: transaction["tds"],
                  tx_status: transaction["tx_status"],
                  status: "success",
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
              end

              render json: {
                success: true,
                message: api_response["message"],
                data: api_response,
                wallet_balance: wallet.reload.balance
              }, status: :ok

            rescue StandardError => e
              Rails.logger.error(e.full_message)

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

              if response[:success]
                render json: response, status: :ok
              else
                render json: response, status: :unprocessable_entity
              end

            rescue StandardError => e
              Rails.logger.error("=" * 100)
              Rails.logger.error("MINI STATEMENT CONTROLLER ERROR => #{e.message}")
              Rails.logger.error(e.backtrace.join("\n"))
              Rails.logger.error("=" * 100)

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