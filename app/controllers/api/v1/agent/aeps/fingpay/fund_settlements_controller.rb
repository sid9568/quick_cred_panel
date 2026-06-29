module Api
  module V1
    module Agent
      module Aeps
        module Fingpay
          class FundSettlementsController < ApplicationController
            protect_from_forgery with: :null_session

			def add_settlemetn_bank

			  required_params = %i[
			    user_code
			    initiator_id
			    bank_id
			    ifsc
			    service_code
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
			    user_code: params[:user_code],
			    initiator_id: params[:initiator_id],
			    bank_id: params[:bank_id],
			    ifsc: params[:ifsc],
			    service_code: params[:service_code],
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
			  required_params = %i[
			    user_code
			    initiator_id
			    service_code
			    amount
			    recipient_id
			    payment_mode
			    client_ref_id
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

			  response = ::Aeps::Fingpay::SettlementService.new.call(
			    user_code: params[:user_code],
			    initiator_id: params[:initiator_id],
			    service_code: params[:service_code],
			    amount: params[:amount],
			    recipient_id: params[:recipient_id],
			    payment_mode: params[:payment_mode],
			    client_ref_id: params[:client_ref_id]
			  )

			  Rails.logger.info("=" * 100)
			  Rails.logger.info("SETTLEMENT RESPONSE => #{response}")
			  Rails.logger.info("=" * 100)

			  render json: response,
			         status: response[:success] ? :ok : :unprocessable_entity

			rescue => e

			  Rails.logger.error("=" * 100)
			  Rails.logger.error("SETTLEMENT ERROR => #{e.message}")
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