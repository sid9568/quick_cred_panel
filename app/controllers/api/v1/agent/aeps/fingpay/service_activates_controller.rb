module Api
  module V1
    module Agent
      module Aeps
        module Fingpay
          class ServiceActivatesController < Api::V1::Auth::BaseController
            # protect_from_forgery with: :null_session

            def get_state
              result = ::Aeps::Fingpay::GetStatesService.new(
                  initiator_id: "6268075916",
                  user_code: "20500001"
                ).call

                if result[:success]
                  render json: result[:body], status: :ok
                else
                  render json: {
                    success: false,
                    error: result[:error] || result[:body]
                  }, status: result[:status] || :unprocessable_entity
                end
            end

           def mcc_category_api
            result = ::Aeps::Fingpay::GetMccCategoryService.new(
              initiator_id: params[:initiator_id] || "6268075916",
              user_code: params[:user_code] || "20500001"
            ).call

            if result[:success]
              render json: {
                success: true,
                message: "MCC Categories fetched successfully",
                data: result[:body]
              }, status: :ok
            else
              render json: {
                success: false,
                message: result[:error] || "Unable to fetch MCC Categories",
                data: result[:body]
              }, status: result[:status] || :unprocessable_entity
            end
          end

            def create
              begin
                address_as_per_proof =
                  if params[:address_as_per_proof].is_a?(String)
                    JSON.parse(params[:address_as_per_proof])
                  elsif params[:address_as_per_proof].present?
                    params[:address_as_per_proof].permit!.to_h
                  else
                    {}
                  end

                office_address =
                  if params[:office_address].is_a?(String)
                    JSON.parse(params[:office_address])
                  elsif params[:office_address].present?
                    params[:office_address].permit!.to_h
                  else
                    {}
                  end

                pan_card_file = params[:pan_card]
                aadhar_front_file = params[:aadhar_front]
                aadhar_back_file = params[:aadhar_back]

                return render json: {
                  success: false,
                  error: "pan_card file is required"
                }, status: :unprocessable_entity unless pan_card_file.present?

                return render json: {
                  success: false,
                  error: "aadhar_front file is required"
                }, status: :unprocessable_entity unless aadhar_front_file.present?

                return render json: {
                  success: false,
                  error: "aadhar_back file is required"
                }, status: :unprocessable_entity unless aadhar_back_file.present?

                response = ::Aeps::Fingpay::ServiceActivite.activate_fingpay_service(
                  user_code: params[:user_code],
                  initiator_id: params[:initiator_id],
                  devicenumber: params[:devicenumber],
                  modelname: params[:modelname],
                  account: params[:account],
                  ifsc: params[:ifsc],
                  aadhar: params[:aadhar],
                  shop_type: params[:shop_type],
                  service_code: params[:service_code],
                  latlong: params[:latlong],
                  address_as_per_proof: address_as_per_proof,
                  office_address: office_address,
                  pan_card: pan_card_file.tempfile.path,
                  aadhar_front: aadhar_front_file.tempfile.path,
                  aadhar_back: aadhar_back_file.tempfile.path
                )

                begin
                  response_body = JSON.parse(response[:body])

                  if response_body["response_status_id"] == 0
                    current_user.update!(aeps_service_activate: true, aeps_latlong: params[:latlong])
                  end

                  render json: response_body, status: :ok
                rescue JSON::ParserError
                  render json: {
                    success: false,
                    error: "Invalid response received from EKO"
                  }, status: :unprocessable_entity
                end
              end


            end
          end
        end
      end
    end
  end
end