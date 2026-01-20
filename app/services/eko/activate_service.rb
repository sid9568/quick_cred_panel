# frozen_string_literal: true

require "httparty"
require "openssl"
require "base64"

module Eko
  class ActivateService
    include HTTParty
    base_uri "https://api.eko.in:25002/ekoicici"

    DEV_KEY    = ENV["EKO_DEVELOPER_KEY"]
    SECRET_KEY = ENV["EKO_SECRET_KEY"]

    def self.call(params)
      new(params).call
    end

    def initialize(params)
      @params = params
    end

    def call
      timestamp  = (Time.now.to_f * 1000).to_i.to_s
      secret_key = generate_secret_key(timestamp)

      url = "/v1/user/service/activate"

      headers = {
        "developer_key" => DEV_KEY,
        "secret-key-timestamp" => timestamp
      }

      body = build_body

      response = self.class.post(
        url,
        headers: headers,
        body: body,
        multipart: true
      )

      handle_response(response)
    rescue => e
      {
        success: false,
        message: "Internal error",
        error: e.message
      }
    end

    private

    def build_body
      {
        initiator_id: @params[:initiator_id],
        user_code: @params[:user_code],
        service_code: @params[:service_code],
        devicenumber: @params[:devicenumber],
        modelname: @params[:modelname],
        latlong: @params[:latlong],
        account: @params[:account],
        ifsc: @params[:ifsc],
        aadhar: @params[:aadhar],
        pan: @params[:pan],
        shop_type: @params[:shop_type],

        office_address: {
          line: @params.dig(:office_address, :line),
          city: @params.dig(:office_address, :city),
          state: @params.dig(:office_address, :state),
          pincode: @params.dig(:office_address, :pincode),
          state_id: @params.dig(:office_address, :state_id)
        },

        address_as_per_proof: {
          line: @params.dig(:address_as_per_proof, :line),
          city: @params.dig(:address_as_per_proof, :city),
          state: @params.dig(:address_as_per_proof, :state),
          pincode: @params.dig(:address_as_per_proof, :pincode),
          state_id: @params.dig(:address_as_per_proof, :state_id)
        },

        pan_card: file(@params[:pan_card]),
        aadhar_front: file(@params[:aadhar_front]),
        aadhar_back: file(@params[:aadhar_back])
      }
    end

    def file(file_param)
      return unless file_param.present?

      File.open(file_param.path)
    end

    def handle_response(response)
      if response.headers["content-type"]&.include?("text/html")
        return {
          success: false,
          message: "EKO service temporarily unavailable",
          http_code: response.code
        }
      end

      parsed = JSON.parse(response.body) rescue {}

      if response.code == 200
        {
          success: true,
          message: parsed["message"] || "Service activated successfully",
          data: parsed
        }
      else
        {
          success: false,
          message: parsed["message"] || "EKO activation failed",
          error: parsed,
          http_code: response.code
        }
      end
    end

    def generate_secret_key(timestamp)
      digest = OpenSSL::HMAC.digest(
        "SHA256",
        SECRET_KEY,
        timestamp
      )
      Base64.strict_encode64(digest)
    end
  end
end
