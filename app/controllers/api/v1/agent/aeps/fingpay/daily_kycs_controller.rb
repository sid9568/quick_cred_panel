module Api
  module V1
    module Agent
      module Aeps
        module Fingpay
          class DailyKycsController < Api::V1::Auth::BaseController
           # protect_from_forgery with: :null_session


          def aeps_user_onboard
              required_params = %i[
                pan_number
                mobile
                first_name
                last_name
                email
                dob
                shop_name
                residence_address
                adhaar_number
              ]

              missing = required_params.select { |key| params[key].blank? }

              if missing.any?
                return render json: {
                  status: 0,
                  message: "Missing params: #{missing.join(', ')}"
                }, status: :bad_request
              end

              response = EkoDmt::UserOnboardService.new(
                initiator_id: "6268075916",
                pan_number: params[:pan_number],
                mobile: params[:mobile],
                first_name: params[:first_name],
                last_name: params[:last_name],
                email: params[:email],
                dob: params[:dob],
                shop_name: params[:shop_name],
                residence_address: params[:residence_address]
              ).call

              Rails.logger.info "========== EKO USER ONBOARD RESPONSE =========="
              Rails.logger.info response.inspect

              user_code = response.dig("data", "user_code") ||
                          response["user_code"] ||
                          response.dig(:data, :user_code) ||
                          response[:user_code]

              Rails.logger.info "========== USER CODE =========="
              Rails.logger.info user_code.inspect

              if user_code.blank?
                return render json: {
                  status: 0,
                  message: response["message"] ||
                           response[:message] ||
                           "User code not received from EKO",
                  raw: response
                }, status: :unprocessable_entity
              end

              user = User.find_or_initialize_by(
                phone_number: params[:mobile],
              )

              p "=================useruser"

              p user

              user.assign_attributes(
                user_code: user_code,
                eko_onboard_first_step: true
              )

              user.save!

              render json: {
                status: 1,
                message: response["message"].presence ||
                         response[:message].presence ||
                         "User onboarded / already exists",
                user_id: user.id,
                user_code: user.user_code,
                eko_onboard_first_step: user.eko_onboard_first_step,
                data: response
              }, status: :ok

            rescue ActiveRecord::RecordInvalid => e
              render json: {
                status: 0,
                message: "User creation failed",
                errors: e.record.errors.full_messages
              }, status: :unprocessable_entity

            rescue StandardError => e
              Rails.logger.error "USER ONBOARD ERROR: #{e.message}"
              Rails.logger.error e.backtrace.join("\n")

              render json: {
                status: 0,
                message: e.message
              }, status: :internal_server_error
          end

          def otp
            client_ref_id = SecureRandom.alphanumeric(16)

            result = ::Aeps::Fingpay::OtpService.new.call(
              client_ref_id: client_ref_id,
              customer_id: current_user.phone_number,
              aadhar: params[:aadhar],
              latlong: current_user.aeps_latlong,
              user_code: current_user.user_code
            )

            render json: result, status: :ok
          end

          def verify
            p "=================user"
            p current_user
            p "================current_user.latitude.to_s"
            p current_user.aeps_latlong
           required_params = %i[
            aadhar
            otp
            otp_ref_id
            reference_tid
          ]

          missing_params = required_params.select { |param| params[param].blank? }

            if missing_params.any?
              return render json: {
                success: false,
                error: "#{missing_params.join(', ')} is required"
              }, status: :unprocessable_entity
            end

            response = ::Aeps::Fingpay::OtpVerifyService.new.call(
              customer_id: current_user.phone_number,
              aadhar: params[:aadhar],
              user_code: current_user.user_code,
              otp: params[:otp],
              otp_ref_id: params[:otp_ref_id],
              reference_tid: params[:reference_tid],
              latlong: current_user.aeps_latlong
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


          def kyc_service
              p "=====================current_user"
              p current_user
              required_params = %i[
                reference_tid
                otp_ref_id
                bank_code
                piddata
              ]

              missing_params = required_params.select { |param| params[param].blank? }

              if missing_params.any?
                return render json: {
                  success: false,
                  error: "#{missing_params.join(', ')} is required"
                }, status: :unprocessable_entity
              end

              if current_user.aeps_latlong.blank?
                return render json: {
                  success: false,
                  error: "AEPS latitude and longitude not found."
                }, status: :unprocessable_entity
              end

              client_ref_id = SecureRandom.alphanumeric(16)

              response = ::Aeps::Fingpay::KycService.call(
                initiator_id: "6268075916",
                user_code: current_user.user_code,
                customer_id: current_user.phone_number,
                client_ref_id: client_ref_id,
                latlong: current_user.aeps_latlong,
                reference_tid: params[:reference_tid],
                otp_ref_id: params[:otp_ref_id],
                bank_code: params[:bank_code],
                ekyc_flag: "0",
                aadhar: current_user.aadhaar_number,
                piddata: params[:piddata]
              )

              if response[:success]
                render json: response, status: :ok
                current_user.update(aeps_kyc: true, bank_code: params[:bank_code])
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
            client_ref_id = "#{Time.current.strftime('%Y%m%d%H%M%S')}#{SecureRandom.random_number(100000..999999)}"

            result = ::Aeps::Fingpay::DailyKycService.new.call(
              initiator_id: "6268075916",
              user_code: current_user.user_code,
              customer_id: current_user.phone_number,
              client_ref_id: client_ref_id,
              latlong: current_user.aeps_latlong,
              bank_code: current_user.bank_code,
              aadhar: current_user.aadhaar_number,
              piddata: params[:piddata]
            )

            if result[:success]
              response_data = result[:data]

              if response_data["response_status_id"] == 0
                current_user.update(daily_aeps_kyc: true)
              end
            end

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