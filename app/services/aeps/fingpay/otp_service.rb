# app/services/aeps/fingpay/otp_service.rb

require "faraday"
require "json"
require "openssl"
require "base64"

module Aeps
  module Fingpay
    class OtpService

      BASE_URL = "https://api.eko.in:25002".freeze
      ENDPOINT = "/ekoicici/v3/user/collection/aeps-fingpay/kyc/otp".freeze

      def initialize
        @developer_key = ENV.fetch("EKO_DEV_KEY")
        @secret_key    = ENV.fetch("EKO_SECRET_KEY")
        @initiator_id  = ENV.fetch("EKO_INITIATOR_ID")
      end

      def call(
        customer_id:,
        client_ref_id:,
        aadhar:,
        latlong:,
        user_code:
      )

        current_timestamp = timestamp
        generated_secret_key = generate_secret_key(current_timestamp)

        encrypted_aadhar = encrypt_aadhaar(aadhar)

        payload = {
          initiator_id: @initiator_id,
          client_ref_id: client_ref_id,
          user_code: user_code,
          customer_id: customer_id,
          aadhar: encrypted_aadhar,
          latlong: latlong
        }

        Rails.logger.info("=" * 100)
        Rails.logger.info("OTP REQUEST URL => #{BASE_URL}#{ENDPOINT}")
        Rails.logger.info("OTP REQUEST HEADERS =>")
        Rails.logger.info(
          {
            developer_key: @developer_key,
            secret_key_timestamp: current_timestamp
          }
        )
        Rails.logger.info("OTP REQUEST PAYLOAD =>")
        Rails.logger.info(payload)
        Rails.logger.info("=" * 100)

        response = connection.post(ENDPOINT) do |req|
          req.headers["developer_key"] = @developer_key
          req.headers["secret-key"] = generated_secret_key
          req.headers["secret-key-timestamp"] = current_timestamp
          req.headers["Content-Type"] = "application/json"

          req.body = payload.to_json
        end

        Rails.logger.info("=" * 100)
        Rails.logger.info("OTP RESPONSE STATUS => #{response.status}")
        Rails.logger.info("OTP RESPONSE BODY => #{response.body}")
        Rails.logger.info("=" * 100)

        {
          success: response.success?,
          status: response.status,
          data: parse_response(response)
        }

      rescue StandardError => e

        Rails.logger.error("=" * 100)
        Rails.logger.error("OTP ERROR CLASS => #{e.class}")
        Rails.logger.error("OTP ERROR MESSAGE => #{e.message}")
        Rails.logger.error(e.backtrace.join("\n"))
        Rails.logger.error("=" * 100)

        {
          success: false,
          message: e.message
        }
      end

      private

      def connection
        Faraday.new(
          url: BASE_URL,
          ssl: { verify: false }
        ) do |f|
          f.response :logger, Rails.logger, bodies: true
          f.adapter Faraday.default_adapter
        end
      end

      def encrypt_aadhaar(aadhaar_number)

        Rails.logger.info("=" * 100)
        Rails.logger.info("AADHAAR => #{aadhaar_number}")

        raw_public_key = ENV.fetch("EKO_PUBLIC_KEY")

        der_bytes = Base64.decode64(raw_public_key)

        public_key = OpenSSL::PKey::RSA.new(der_bytes)

        encrypted = public_key.public_encrypt(
          aadhaar_number.to_s,
          OpenSSL::PKey::RSA::PKCS1_PADDING
        )

        Base64.strict_encode64(encrypted)
      end

      def generate_secret_key(timestamp)

        encoded_key = Base64.strict_encode64(@secret_key)

        digest = OpenSSL::HMAC.digest(
          "sha256",
          encoded_key,
          timestamp.to_s
        )

        Base64.strict_encode64(digest)
      end

      def timestamp
        (Time.now.to_f * 1000).to_i.to_s
      end

      def parse_response(response)
        JSON.parse(response.body)
      rescue JSON::ParserError
        response.body
      end
    end
  end
end