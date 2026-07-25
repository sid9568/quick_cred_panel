# app/services/aeps/fingpay/update_settlement_account_service.rb

require "faraday"
require "json"
require "openssl"
require "base64"
require "securerandom"

module Aeps
  module Fingpay
    class UpdateSettlementAccountService

      BASE_URL = "https://api.eko.in:25002".freeze
      ENDPOINT = "/ekoicici/v3/user/payment/aeps/settlement/account".freeze

      def initialize
        @developer_key = ENV.fetch("EKO_DEV_KEY")
        @secret_key    = ENV.fetch("EKO_SECRET_KEY")
        @initiator_id  = ENV.fetch("EKO_INITIATOR_ID")
      end

      def call(
        user_code:,
        bank_id:,
        ifsc:,
        service_code:,
        account:
      )

        current_timestamp = timestamp
        generated_secret_key = generate_secret_key(current_timestamp)
        client_ref_id = generate_client_ref_id

        payload = {
          initiator_id: @initiator_id,
          client_ref_id: client_ref_id,
          user_code: user_code,
          bank_id: bank_id,
          ifsc: ifsc,
          service_code: service_code,
          account: account
        }

        Rails.logger.info("=" * 100)
        Rails.logger.info("UPDATE SETTLEMENT ACCOUNT REQUEST")
        Rails.logger.info("URL => #{BASE_URL}#{ENDPOINT}")
        Rails.logger.info("PAYLOAD => #{payload}")
        Rails.logger.info("=" * 100)

        response = connection.post(ENDPOINT) do |req|
          req.headers["developer_key"] = @developer_key
          req.headers["secret-key"] = generated_secret_key
          req.headers["secret-key-timestamp"] = current_timestamp
          req.headers["Content-Type"] = "application/json"

          req.body = payload.to_json
        end

        Rails.logger.info("=" * 100)
        Rails.logger.info("STATUS => #{response.status}")
        Rails.logger.info("BODY => #{response.body}")
        Rails.logger.info("=" * 100)

        {
          success: response.success?,
          status: response.status,
          data: parse_response(response)
        }

      rescue StandardError => e
        Rails.logger.error(e.full_message)

        {
          success: false,
          error: e.message
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

      def generate_secret_key(timestamp)
        encoded_key = Base64.strict_encode64(@secret_key)

        digest = OpenSSL::HMAC.digest(
          "sha256",
          encoded_key,
          timestamp.to_s
        )

        Base64.strict_encode64(digest)
      end

      def generate_client_ref_id
        "#{Time.current.strftime('%Y%m%d%H%M%S')}#{SecureRandom.random_number(100000).to_s.rjust(5, '0')}"
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