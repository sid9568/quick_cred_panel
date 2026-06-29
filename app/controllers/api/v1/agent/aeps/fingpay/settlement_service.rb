require "faraday"
require "json"
require "openssl"
require "base64"

module Aeps
  module Fingpay
    class SettlementService

      BASE_URL = "https://api.eko.in:25002".freeze

      def initialize
        @developer_key = ENV.fetch("EKO_DEV_KEY")
        @secret_key    = ENV.fetch("EKO_SECRET_KEY")
      end

      def call(
        user_code:,
        initiator_id:,
        service_code:,
        amount:,
        recipient_id:,
        payment_mode:,
        client_ref_id:
      )

        current_timestamp = timestamp
        generated_secret_key = generate_secret_key(current_timestamp)

        endpoint =
          "/ekoicici/v1/agent/user_code:#{user_code}/settlement"

        request_body = {
          initiator_id: initiator_id,
          service_code: service_code,
          amount: amount,
          recipient_id: recipient_id,
          payment_mode: payment_mode,
          client_ref_id: client_ref_id
        }

        Rails.logger.info("=" * 100)
        Rails.logger.info("SETTLEMENT REQUEST")
        Rails.logger.info("URL => #{BASE_URL}#{endpoint}")
        Rails.logger.info("TIMESTAMP => #{current_timestamp}")
        Rails.logger.info("REQUEST BODY => #{request_body.to_json}")
        Rails.logger.info("=" * 100)

        response = connection(
          generated_secret_key,
          current_timestamp
        ).post(endpoint) do |req|

          req.headers["Content-Type"] =
            "application/x-www-form-urlencoded"

          req.body = request_body
        end

        Rails.logger.info("=" * 100)
        Rails.logger.info("SETTLEMENT RESPONSE")
        Rails.logger.info("STATUS => #{response.status}")
        Rails.logger.info("BODY => #{response.body}")
        Rails.logger.info("=" * 100)

        {
          success: response.success?,
          status: response.status,
          data: parse_response(response)
        }

      rescue => e

        Rails.logger.error("=" * 100)
        Rails.logger.error("SETTLEMENT ERROR")
        Rails.logger.error("MESSAGE => #{e.message}")
        Rails.logger.error(e.backtrace.join("\n"))
        Rails.logger.error("=" * 100)

        {
          success: false,
          error: e.message
        }
      end

      private

      def connection(secret_key, timestamp)

        Faraday.new(
          url: BASE_URL,
          ssl: { verify: false }
        ) do |f|

          f.request :url_encoded

          f.headers["developer_key"] = @developer_key
          f.headers["secret-key"] = secret_key
          f.headers["secret-key-timestamp"] = timestamp

          f.response :logger,
                     Rails.logger,
                     headers: true,
                     bodies: true

          f.adapter Faraday.default_adapter
        end
      end

      def generate_secret_key(timestamp)

        encoded_key =
          Base64.strict_encode64(@secret_key)

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