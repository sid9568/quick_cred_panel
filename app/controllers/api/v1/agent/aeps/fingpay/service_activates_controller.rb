module Api
  module V1
    module Agent
      module Aeps
        module Fingpay
          class ServiceActivatesController < ApplicationController
            protect_from_forgery with: :null_session

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

                render json: {
                  success: true,
                  response: response
                }

              rescue => e
                render json: {
                  success: false,
                  error: e.message,
                  backtrace: e.backtrace.first(5)
                }, status: :unprocessable_entity
              end
            end
          end
        end
      end
    end
  end
end