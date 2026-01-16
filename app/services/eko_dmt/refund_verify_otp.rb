# frozen_string_literal: true

require "httparty"
require "openssl"
require "base64"

module EkoDmt
  class RefundVerifyOtp
    include HTTParty

    BASE_URL = "https://staging.eko.in/ekoapi/v2/transactions"

    def self.call(transaction_id:, initiator_id:, otp:, state:, user_code:)
      timestamp = (Time.now.to_f * 1000).to_i.to_s
      developer_key = ENV["EKO_DEV_KEY"]
      access_key    = ENV["EKO_SECRET_KEY"]

      encoded_key = Base64.strict_encode64(access_key)
      secret_key  = Base64.strict_encode64(
        OpenSSL::HMAC.digest("SHA256", encoded_key, timestamp)
      )

      headers = {
        "developer_key"        => developer_key,
        "secret-key"           => secret_key,
        "secret-key-timestamp" => timestamp,
        "Content-Type"         => "application/x-www-form-urlencoded"
      }

      body = {
        initiator_id: initiator_id,
        otp: otp,
        state: state,
        user_code: user_code
      }

      url = "#{BASE_URL}/#{transaction_id}/refund"

      response = post(url, headers: headers, body: body)

      response.parsed_response
    rescue => e
      { status: false, message: e.message }
    end
  end
end

