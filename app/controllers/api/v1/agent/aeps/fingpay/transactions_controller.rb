module Api
  module V1
    module Agent
      module Aeps
        module Fingpay
          class TransactionsController < Api::V1::Auth::BaseController

            def create

              required_params = %i[
                service_type
                initiator_id
                user_code
                customer_id
                bank_code
                amount
                client_ref_id
                pipe
                aadhar
                notify_customer
                piddata
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

              response = ::Aeps::Fingpay::TransactionService.new.call(
                service_type: params[:service_type],
                initiator_id: params[:initiator_id],
                user_code: params[:user_code],
                customer_id: params[:customer_id],
                bank_code: params[:bank_code],
                amount: params[:amount],
                client_ref_id: params[:client_ref_id],
                pipe: params[:pipe],
                aadhar: params[:aadhar],
                notify_customer: params[:notify_customer],
                piddata: params[:piddata]
              )

              if response[:success]
                render json: response, status: :ok
              else
                render json: response, status: :unprocessable_entity
              end

            rescue => e

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