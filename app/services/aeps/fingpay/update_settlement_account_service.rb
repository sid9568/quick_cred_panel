# app/services/aeps/fingpay/update_settlement_account_service.rb

require "faraday"
require "json"
require "openssl"
require "base64"

module Aeps
  module Fingpay
    class UpdateSettlementAccountService

      BASE_URL = "https://api.eko.in:25002".freeze

      def initialize
        @developer_key = ENV.fetch("EKO_DEV_KEY")
        @secret_key    = ENV.fetch("EKO_SECRET_KEY")
      end

      def call(
        user_code:,
        initiator_id:,
        bank_id:,
        ifsc:,
        service_code:,
        account:
      )

        current_timestamp = timestamp
        generated_secret_key = generate_secret_key(current_timestamp)

        endpoint =
          "/ekoicici/v1/agent/user_code:#{user_code}/settlementaccount"

        request_body = {
          initiator_id: initiator_id,
          bank_id: bank_id,
          ifsc: ifsc,
          service_code: service_code,
          account: account
        }

        Rails.logger.info("=" * 100)
        Rails.logger.info("UPDATE SETTLEMENT ACCOUNT REQUEST")
        Rails.logger.info("BASE URL => #{BASE_URL}")
        Rails.logger.info("ENDPOINT => #{endpoint}")
        Rails.logger.info("METHOD => PUT")
        Rails.logger.info("DEVELOPER KEY => #{@developer_key}")
        Rails.logger.info("TIMESTAMP => #{current_timestamp}")
        Rails.logger.info("GENERATED SECRET KEY => #{generated_secret_key}")
        Rails.logger.info("REQUEST BODY => #{request_body.to_json}")
        Rails.logger.info("=" * 100)

        connection = Faraday.new(
          url: BASE_URL,
          ssl: { verify: false }
        ) do |f|

          f.request :url_encoded

          f.response :logger,
                     Rails.logger,
                     headers: true,
                     bodies: true,
                     log_level: :info

          f.adapter Faraday.default_adapter
        end

        response = connection.put(endpoint) do |req|

          req.headers["Content-Type"] = "application/x-www-form-urlencoded"
          req.headers["developer_key"] = @developer_key
          req.headers["secret-key"] = generated_secret_key
          req.headers["secret-key-timestamp"] = current_timestamp
          req.headers["cache-control"] = "no-cache"

          req.body = request_body
        end

        Rails.logger.info("=" * 100)
        Rails.logger.info("UPDATE SETTLEMENT ACCOUNT RESPONSE")
        Rails.logger.info("STATUS => #{response.status}")
        Rails.logger.info("HEADERS => #{response.headers.to_h}")
        Rails.logger.info("BODY => #{response.body}")
        Rails.logger.info("=" * 100)

        parsed_response =
          begin
            JSON.parse(response.body)
          rescue JSON::ParserError
            response.body
          end

        Rails.logger.info("=" * 100)
        Rails.logger.info("PARSED RESPONSE => #{parsed_response}")
        Rails.logger.info("=" * 100)

        {
          success: response.success?,
          status: response.status,
          data: parsed_response
        }

      rescue Faraday::Error => e

        Rails.logger.error("=" * 100)
        Rails.logger.error("FARADAY ERROR")
        Rails.logger.error("ERROR CLASS => #{e.class}")
        Rails.logger.error("ERROR MESSAGE => #{e.message}")
        Rails.logger.error("BACKTRACE =>")
        Rails.logger.error(e.backtrace.join("\n"))
        Rails.logger.error("=" * 100)

        {
          success: false,
          error: e.message
        }

      rescue => e

        Rails.logger.error("=" * 100)
        Rails.logger.error("UPDATE SETTLEMENT ACCOUNT ERROR")
        Rails.logger.error("ERROR CLASS => #{e.class}")
        Rails.logger.error("ERROR MESSAGE => #{e.message}")
        Rails.logger.error("BACKTRACE =>")
        Rails.logger.error(e.backtrace.join("\n"))
        Rails.logger.error("=" * 100)

        {
          success: false,
          error: e.message
        }
      end

      private

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
    end
  end
end