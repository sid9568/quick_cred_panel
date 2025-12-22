# app/services/eko/biometric_ekyc_service.rb
require "faraday"
require "openssl"
require "base64"
require "uri"
require "json"

module EkoDmt
  class BiometricEkycService
    BASE_URL = "https://api.eko.in:25002/ekoicici"

    def initialize(customer_id:, aadhar:, piddata:, user_code:, initiator_id:)
      @customer_id = customer_id
      @aadhar      = aadhar
      @piddata     = piddata
    end

    def call
      response = Faraday.post(api_url) do |req|
        req.headers = headers
        req.body    = URI.encode_www_form(payload)
      end

      {
        status: response.status,
        body: response.body,
        parsed: parse(response.body)
      }
    rescue => e
      { status: 500, error: e.message }
    end

    private

    # 🔗 SAME URL AS CURL
    def api_url
      "#{BASE_URL}/v3/customer/account/#{@customer_id}/dmt-fino/ekyc"
    end

    # 1️⃣ TIMESTAMP (milliseconds)
    def timestamp
      @timestamp ||= (Time.now.to_f * 1000).to_i.to_s
    end

    # 2️⃣ SECRET KEY (EXACT EKO LOGIC)
    # Base64( HMAC_SHA256( Base64(secret_key), timestamp ) )
    def secret_key
      access_key = ENV["EKO_SECRET_KEY"]

      encoded_key = Base64.strict_encode64(access_key)
      hmac        = OpenSSL::HMAC.digest("SHA256", encoded_key, timestamp)

      Base64.strict_encode64(hmac)
    end

    # 3️⃣ HEADERS (EXACT SAME AS CURL)
    def headers
      {
        "developer_key"        => ENV["EKO_DEV_KEY"],
        "secret-key"           => secret_key,
        "secret-key-timestamp" => timestamp,
        "Content-Type"         => "application/x-www-form-urlencoded"
      }
    end

    # 4️⃣ PAYLOAD (FORM URL ENCODED – SAME AS CURL)
    def payload
      {
        user_code:    ENV["EKO_USER_CODE"],
        initiator_id: ENV["EKO_INITIATOR_ID"],
        aadhar:       @aadhar,
        piddata:      @piddata
      }
    end

    def parse(body)
      JSON.parse(body)
    rescue
      body
    end
  end
end
