# app/services/aeps/fingpay/kyc_service.rb

require "faraday"
require "json"
require "openssl"
require "base64"

module Aeps
  module Fingpay
    class KycService
      BASE_URL = "https://api.eko.in:25002".freeze
      ENDPOINT = "/ekoicici/v2/aeps/kyc".freeze

      def self.call(
        initiator_id:,
        user_code:,
        customer_id:,
        client_ref_id:,
        latlong:,
        reference_tid:,
        otp_ref_id:,
        bank_code:,
        ekyc_flag:,
        aadhar:,
        piddata:
      )

        payload = {
          initiator_id: initiator_id,
          user_code: user_code,
          customer_id: customer_id,
          client_ref_id: client_ref_id,
          latlong: latlong,
          reference_tid: reference_tid,
          otp_ref_id: otp_ref_id,
          bank_code: bank_code,
          ekyc_flag: ekyc_flag,
          aadhar: aadhar,
          piddata: piddata
        }

        current_timestamp    = timestamp
        generated_secret_key = generate_secret_key(current_timestamp)

        headers = {
          "Content-Type"         => "application/json",
          "developer_key"        => ENV.fetch("EKO_DEV_KEY"),
          "secret-key"           => generated_secret_key,
          "secret-key-timestamp" => current_timestamp
        }

        Rails.logger.info("=" * 100)
        Rails.logger.info("[EKO KYC REQUEST START]")
        Rails.logger.info("[EKO KYC URL] #{BASE_URL}#{ENDPOINT}")
        Rails.logger.info("[EKO KYC TIMESTAMP] #{current_timestamp}")
        Rails.logger.info("[EKO KYC GENERATED SECRET KEY] #{generated_secret_key}")
        Rails.logger.info("[EKO KYC DEVELOPER KEY] #{ENV.fetch('EKO_DEV_KEY')}")
        Rails.logger.info("[EKO KYC HEADERS] #{headers.to_json}")

        masked_payload = payload.deep_dup
        masked_payload[:aadhar] = "***MASKED***"

        Rails.logger.info("[EKO KYC PAYLOAD] #{masked_payload.to_json}")
        Rails.logger.info("=" * 100)

        connection = Faraday.new(
          url: BASE_URL,
          ssl: { verify: false }
        ) do |f|
          f.response :logger, Rails.logger, bodies: true
          f.adapter Faraday.default_adapter
        end

        response = connection.post(ENDPOINT) do |req|
          headers.each { |k, v| req.headers[k] = v }
          req.body = payload.to_json
        end

        Rails.logger.info("=" * 100)
        Rails.logger.info("[EKO KYC RESPONSE STATUS] #{response.status}")
        Rails.logger.info("[EKO KYC RESPONSE HEADERS] #{response.headers.inspect}")
        Rails.logger.info("[EKO KYC RESPONSE BODY] #{response.body}")
        Rails.logger.info("=" * 100)

        parsed_body =
          begin
            JSON.parse(response.body)
          rescue JSON::ParserError
            response.body
          end

        {
          success: response.success?,
          status: response.status,
          body: parsed_body
        }

      rescue => e

        Rails.logger.error("=" * 100)
        Rails.logger.error("[EKO KYC ERROR CLASS] #{e.class}")
        Rails.logger.error("[EKO KYC ERROR MESSAGE] #{e.message}")
        Rails.logger.error("[EKO KYC ERROR BACKTRACE]")
        Rails.logger.error(e.backtrace.first(20).join("\n"))
        Rails.logger.error("=" * 100)

        {
          success: false,
          error: e.message
        }
      end

      private

      def self.generate_secret_key(timestamp)
        secret_key = ENV.fetch("EKO_SECRET_KEY")

        encoded_key = Base64.strict_encode64(secret_key)

        digest = OpenSSL::HMAC.digest(
          "sha256",
          encoded_key,
          timestamp.to_s
        )

        Base64.strict_encode64(digest)
      end

      def self.timestamp
        (Time.now.to_f * 1000).to_i.to_s
      end
    end
  end
end