module Api
  module V1
    module Agent
      module Aeps
        module Fingpay
          class DailyKycsController < ApplicationController
           protect_from_forgery with: :null_session

          def otp
            result = ::Aeps::Fingpay::OtpService.new.call(
              customer_id: params[:customer_id],
              aadhar: params[:aadhar],
              latlong: params[:latlong],
              user_code: params[:user_code]
            )

            render json: result, status: :ok
          end

          def verify
            required_params = %i[
              customer_id
              aadhar
              user_code
              otp
              otp_ref_id
              reference_tid
              latlong
            ]

            missing_params = required_params.select { |param| params[param].blank? }

            if missing_params.any?
              return render json: {
                success: false,
                error: "#{missing_params.join(', ')} is required"
              }, status: :unprocessable_entity
            end

            response = ::Aeps::Fingpay::OtpVerifyService.new.call(
              customer_id: params[:customer_id],
              aadhar: params[:aadhar],
              user_code: params[:user_code],
              otp: params[:otp],
              otp_ref_id: params[:otp_ref_id],
              reference_tid: params[:reference_tid],
              latlong: params[:latlong]
            )

            if response[:success]
              render json: {
                success: true,
                data: response[:data]
              }, status: :ok
            else
              render json: {
                success: false,
                error: response[:error] || response[:data]
              }, status: :unprocessable_entity
            end

          rescue => e
            render json: {
              success: false,
              error: e.message
            }, status: :internal_server_error
        end

          # EKO_INITIATOR_ID = 6268075916
          # EKO_USER_CODE = 20500001
          # 38130024

        def kyc_service
              required_params = %i[
                initiator_id
                user_code
                customer_id
                client_ref_id
                latlong
                reference_tid
                otp_ref_id
                bank_code
                ekyc_flag
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

              response = ::Aeps::Fingpay::KycService.call(
                initiator_id: params[:initiator_id],
                user_code: params[:user_code],
                customer_id: params[:customer_id],
                client_ref_id: params[:client_ref_id],
                latlong: params[:latlong],
                reference_tid: params[:reference_tid],
                otp_ref_id: params[:otp_ref_id],
                bank_code: params[:bank_code],
                ekyc_flag: params[:ekyc_flag],
                aadhar: params[:aadhar],
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

            def create
                result = ::Aeps::Fingpay::DailyKycService.new.call(
                initiator_id: "6268075916",
                user_code: "38130024",
                customer_id: "8512889672",
                client_ref_id: "202105311125123456",
                latlong: "25.340870,82.996858",
                bank_code: "ICIC",
                aadhar: "252262716014",
                piddata: params[:piddata]
                )

              render json: result, status: :ok
            end

            # def transaction
            #    result = ::Aeps::Fingpay::TransactionService.new.call(
            #       service_type: params[:service_type],
            #       initiator_id: params[:initiator_id],
            #       user_code: params[:user_code],
            #       customer_id: params[:customer_id],
            #       bank_code: params[:bank_code],
            #       amount: params[:amount],
            #       client_ref_id: params[:client_ref_id],
            #       pipe: params[:pipe],
            #       aadhar: params[:aadhar],                 # encrypted
            #       aadhaar_number: params[:aadhaar_number], # plain, only hash generation
            #       notify_customer: params[:notify_customer],
            #       piddata: params[:piddata]
            #     )

            #   render json: result
            # end

            def transaction
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
                latlong
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
                piddata: params[:piddata],
                latlong: params[:latlong]
              )

              if response[:success]

                if response[:data].is_a?(Hash) &&
                   response[:data]["status"] == 0 &&
                   response[:data]["response_type_id"] == 1605 &&
                   response[:data]["message"] == "Congratulations! eKYC successful"

                  current_user.update!(aeps_kyc: true)
                end

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