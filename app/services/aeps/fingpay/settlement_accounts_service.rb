require "faraday"
require "json"
require "openssl"
require "base64"
require "securerandom"

module Aeps
  module Fingpay
    class SettlementAccountsService

      BASE_URL = "https://api.eko.in:25002".freeze
      ENDPOINT = "/ekoicici/v3/user/payment/aeps/settlement/accounts".freeze

      def initialize
        @developer_key = ENV.fetch("EKO_DEV_KEY")
        @secret_key    = ENV.fetch("EKO_SECRET_KEY")
        @initiator_id  = ENV.fetch("EKO_INITIATOR_ID")
      end

      def call(user_code:)

        current_timestamp = timestamp
        generated_secret_key = generate_secret_key(current_timestamp)
        client_ref_id = generate_client_ref_id

        Rails.logger.info("=" * 100)
        Rails.logger.info("SETTLEMENT ACCOUNTS REQUEST")
        Rails.logger.info("URL => #{BASE_URL}#{ENDPOINT}")
        Rails.logger.info("USER CODE => #{user_code}")
        Rails.logger.info("CLIENT REF ID => #{client_ref_id}")
        Rails.logger.info("=" * 100)

        response = connection(
          timestamp: current_timestamp,
          secret_key: generated_secret_key
        ).get(ENDPOINT) do |req|

          req.params["initiator_id"] = @initiator_id
          req.params["client_ref_id"] = client_ref_id
          req.params["user_code"] = user_code
        end

        Rails.logger.info("=" * 100)
        Rails.logger.info("SETTLEMENT ACCOUNTS RESPONSE")
        Rails.logger.info("STATUS => #{response.status}")
        Rails.logger.info("BODY => #{response.body}")
        Rails.logger.info("=" * 100)

        {
          success: response.success?,
          status: response.status,
          data: parse_response(response)
        }

      rescue StandardError => e

        Rails.logger.error("=" * 100)
        Rails.logger.error("SETTLEMENT ACCOUNTS ERROR")
        Rails.logger.error(e.full_message)
        Rails.logger.error("=" * 100)

        {
          success: false,
          error: e.message
        }
      end

      private

      def connection(timestamp:, secret_key:)
        Faraday.new(
          url: BASE_URL,
          ssl: { verify: false }
        ) do |f|

          f.headers["Content-Type"] = "application/json"
          f.headers["developer_key"] = @developer_key
          f.headers["secret-key"] = secret_key
          f.headers["secret-key-timestamp"] = timestamp

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