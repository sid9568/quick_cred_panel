require "faraday"
require "json"
require "openssl"
require "base64"

module Aeps
  module Fingpay
    class AccountBalanceService
      BASE_URL = "https://api.eko.in:25002".freeze

      def initialize
        @developer_key = ENV.fetch("EKO_DEV_KEY")
        @secret_key    = ENV.fetch("EKO_SECRET_KEY")
        @initiator_id  = ENV.fetch("EKO_INITIATOR_ID")
      end

      def call(customer_id_type:, customer_id:, user_code:)
        current_timestamp = timestamp

        endpoint = "/ekoicici/v2/customers/#{customer_id_type}:#{customer_id}/balance"

        response = connection(current_timestamp).get(endpoint) do |req|
          req.params["initiator_id"] = @initiator_id
          req.params["user_code"]    = user_code
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

      def connection(current_timestamp)
        generated_secret_key = generate_secret_key(current_timestamp)

        Faraday.new(
          url: BASE_URL,
          ssl: { verify: false }
        ) do |f|
          f.headers["developer_key"] = @developer_key
          f.headers["secret-key"] = generated_secret_key
          f.headers["secret-key-timestamp"] = current_timestamp
          f.headers["Accept"] = "application/json"

          f.response :logger, Rails.logger, bodies: true
          f.adapter Faraday.default_adapter
        end
      end

      def generate_secret_key(timestamp)
        encoded_key = Base64.strict_encode64(@secret_key)

        digest = OpenSSL::HMAC.digest(
          "SHA256",
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