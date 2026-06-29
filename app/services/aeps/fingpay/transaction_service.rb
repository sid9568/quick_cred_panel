# app/services/aeps/fingpay/transaction_service.rb

require "faraday"
require "json"
require "openssl"
require "base64"

module Aeps
  module Fingpay
    class TransactionService
      p "=================TransactionService======================"
      p "ye toh chal rha hai"

      BASE_URL = "https://api.eko.in:25002".freeze
      ENDPOINT = "/ekoicici/v2/aeps".freeze

      def initialize
        @developer_key = ENV.fetch("EKO_DEV_KEY")
        @secret_key    = ENV.fetch("EKO_SECRET_KEY")
      end

      def call(
        service_type:,
        initiator_id:,
        user_code:,
        customer_id:,
        bank_code:,
        amount:,
        client_ref_id:,
        pipe:,
        aadhar:,
        notify_customer:,
        piddata:,
        latlong:
      )

        current_timestamp = timestamp

        encrypted_aadhar = encrypt_aadhaar(aadhar)

        payload = {
          service_type: service_type,
          initiator_id: initiator_id,
          user_code: user_code,
          customer_id: customer_id,
          bank_code: bank_code,
          amount: amount,
          client_ref_id: client_ref_id,
          pipe: pipe,
          aadhar: encrypted_aadhar,
          notify_customer: notify_customer,
          piddata: piddata,
          latlong: latlong
        }

        response = connection(
          timestamp: current_timestamp,
          plain_aadhar: aadhar,
          amount: amount,
          user_code: user_code
        ).post(ENDPOINT) do |req|
          req.body = payload.to_json
        end

        {
          success: response.success?,
          status: response.status,
          data: parse_response(response)
        }

      rescue StandardError => e
        {
          success: false,
          error: e.message
        }
      end

      private

      def connection(timestamp:, plain_aadhar:, amount:, user_code:)

        secret_key = generate_secret_key(timestamp)

        request_hash = generate_request_hash(
          timestamp: timestamp,
          aadhar: plain_aadhar,
          amount: amount,
          user_code: user_code
        )

        Faraday.new(
          url: BASE_URL,
          ssl: { verify: false }
        ) do |f|

          f.headers["Content-Type"] = "application/json"
          f.headers["developer_key"] = @developer_key
          f.headers["secret-key"] = secret_key
          f.headers["secret-key-timestamp"] = timestamp
          f.headers["request_hash"] = request_hash

          f.response :logger, Rails.logger, bodies: true
          f.adapter Faraday.default_adapter
        end
      end

      def encrypt_aadhaar(aadhaar_number)

          Rails.logger.info("=" * 100)
          Rails.logger.info("AADHAR => #{aadhaar_number}")
          Rails.logger.info("AADHAR LENGTH => #{aadhaar_number.to_s.length}")

          raw_public_key = ENV.fetch("EKO_PUBLIC_KEY")

          Rails.logger.info("PUBLIC KEY LENGTH => #{raw_public_key.length}")
          Rails.logger.info("PUBLIC KEY START => #{raw_public_key[0..50]}")

          der_bytes = Base64.decode64(raw_public_key)

          Rails.logger.info("DER BYTES LENGTH => #{der_bytes.length}")

          public_key = OpenSSL::PKey::RSA.new(der_bytes)

          Rails.logger.info("RSA KEY SIZE => #{public_key.n.num_bits}")

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

      def generate_request_hash(
        timestamp:,
        aadhar:,
        amount:,
        user_code:
      )

        data = "#{timestamp}#{aadhar}#{amount}#{user_code}"

        encoded_key = Base64.strict_encode64(@secret_key)

        digest = OpenSSL::HMAC.digest(
          "sha256",
          encoded_key,
          data
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