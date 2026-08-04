module Api
  module V1
    module Agent
      module Aeps
        module Fingpay
          class FundSettlementsController < Api::V1::Auth::BaseController
            # protect_from_forgery with: :null_session

           def balance_check
           	p "==========balance_checkbalance_check==========="
           	p current_user
					  aeps_wallet = AepsWallet.find_or_create_by!(user: current_user) do |wallet|
					    wallet.balance = 0
					  end

					  render json: {
					    success: true,
					    balance: aeps_wallet.balance
					  }, status: :ok
					end

          def settlement_accounts
					  response = ::Aeps::Fingpay::SettlementAccountsService.new.call(
					    user_code: current_user.user_code
					  )

					  if response[:success]
					    render json: response, status: :ok
					  else
					    render json: response, status: :unprocessable_entity
					  end

					rescue StandardError => e
					  Rails.logger.error(e.full_message)

					  render json: {
					    success: false,
					    error: e.message
					  }, status: :internal_server_error
					end

					def add_settlemetn_bank

					  required_params = %i[
					   	bank_id
					    ifsc
					    account
					  ]

					  missing_params = required_params.select do |param|
					    params[param].blank?
					  end

					  if missing_params.any?
					    return render json: {
					      success: false,
					      error: "#{missing_params.join(', ')} is required"
					    }, status: :unprocessable_entity
					  end

					  response = ::Aeps::Fingpay::UpdateSettlementAccountService.new.call(
					    user_code: current_user.user_code,
					    bank_id: params[:bank_id],
					    ifsc: params[:ifsc],
					    service_code: "39",
					    account: params[:account]
					  )

					  Rails.logger.info("=" * 100)
					  Rails.logger.info("SETTLEMENT ACCOUNT RESPONSE => #{response}")
					  Rails.logger.info("=" * 100)

					  render json: response, status: :ok

					rescue => e

					  Rails.logger.error("=" * 100)
					  Rails.logger.error("SETTLEMENT ACCOUNT ERROR => #{e.message}")
					  Rails.logger.error(e.backtrace.join("\n"))
					  Rails.logger.error("=" * 100)

					  render json: {
					    success: false,
					    error: e.message
					  }, status: :unprocessable_entity
				end

				 def settlements
						  required_params = %i[amount recipient_id]

						  missing_params = required_params.select { |param| params[param].blank? }

						  if missing_params.present?
						    return render json: {
						      success: false,
						      message: "#{missing_params.join(', ')} is required"
						    }, status: :unprocessable_entity
						  end

						  amount = params[:amount].to_f

						  # Find or Create AEPS Wallet
						  aeps_wallet = AepsWallet.find_or_create_by!(user: current_user)

						  # Check Wallet Balance
						  if aeps_wallet.balance.to_f < amount
						    return render json: {
						      success: false,
						      message: "Insufficient wallet balance.",
						      available_balance: aeps_wallet.balance.to_f
						    }, status: :unprocessable_entity
						  end

						  # Settlement API Call
						  response = ::Aeps::Fingpay::SettlementService.new.call(
						    user_code: current_user.user_code,
						    amount: amount,
						    recipient_id: params[:recipient_id],
						    payment_mode: 5
						  )

						  Rails.logger.info("=" * 100)
						  Rails.logger.info("SETTLEMENT RESPONSE => #{response}")
						  Rails.logger.info("=" * 100)

						  api_response = response[:data]
						  settlement   = api_response["data"]

						  # Deduct wallet only if settlement is successful
						  if response[:success] &&
						     api_response["status"].to_i.zero? &&
						     settlement["tx_status"].to_s == "0"

						    ActiveRecord::Base.transaction do
						      aeps_wallet.lock!

						      balance_before = aeps_wallet.balance.to_f
						      balance_after  = balance_before - amount

						      aeps_wallet.update!(balance: balance_after)

						      AepsWalletTransaction.create!(
						        user: current_user,
						        aeps_wallet: aeps_wallet,
						        amount: amount,
						        transaction_type: :debit,
						        reference_id: settlement["tid"],
						        remarks: "AEPS Settlement",
						        balance_before: balance_before,
						        balance_after: balance_after,
						        status: :success
						      )
						    end
						  end

						  render json: response,
						         status: response[:success] ? :ok : :unprocessable_entity

						rescue StandardError => e
						  Rails.logger.error("=" * 100)
						  Rails.logger.error("SETTLEMENT ERROR => #{e.message}")
						  Rails.logger.error(e.backtrace.join("\n"))
						  Rails.logger.error("=" * 100)

						  render json: {
						    success: false,
						    message: e.message
						  }, status: :internal_server_error
						end


          end
        end
      end
    end
  end
end