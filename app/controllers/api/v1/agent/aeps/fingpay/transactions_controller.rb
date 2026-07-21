module Api
  module V1
    module Agent
      module Aeps
        module Fingpay
          class TransactionsController < Api::V1::Auth::BaseController

            require "securerandom"

            def create
              required_params = %i[
                service_type
                bank_code
                amount
                piddata
              ]

              missing_params = required_params.select { |param| params[param].blank? }

              if missing_params.any?
                return render json: {
                  success: false,
                  error: "#{missing_params.join(', ')} is required"
                }, status: :unprocessable_entity
              end

              # user = User.find_by(phone_number: params[:phone_number])

              # unless user
              #   return render json: {
              #     success: false,
              #     error: "User not found"
              #   }, status: :not_found
              # end

              # Generate unique client reference ID
              client_ref_id = "#{Time.current.strftime('%Y%m%d%H%M%S')}#{SecureRandom.random_number(1000..9999)}"

              response = ::Aeps::Fingpay::TransactionService.new.call(
                service_type: params[:service_type],
                initiator_id: "6268075916",
                user_code: current_user.user_code,
                customer_id: params[:phone_number],
                bank_code: params[:bank_code],
                amount: params[:amount],
                client_ref_id: client_ref_id,
                pipe: "0",
                aadhar: params[:aadhar],
                notify_customer: "1",
                latlong: current_user.aeps_latlong,
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