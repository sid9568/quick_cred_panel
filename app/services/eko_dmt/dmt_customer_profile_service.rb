# app/services/eko/dmt_customer_profile_service.rb

require "httparty"
require "openssl"
require "base64"

module EkoDmt
  class DmtCustomerProfileService
    BASE_URL = "https://api.eko.in:25002/ekoicici/v3/customer/profile".freeze

    def initialize(customer_id:)
      @customer_id  = customer_id
      @initiator_id = "6268075916"
      @user_code     = "20500001"

      @developer_key = ENV.fetch("EKO_DEV_KEY")
      @access_key    = ENV.fetch("EKO_SECRET_KEY")
    end

    def call
      timestamp = (Time.now.to_f * 1000).to_i.to_s

      url = "#{BASE_URL}/#{@customer_id}/dmt-fino"

      headers = generate_headers(timestamp)

      query = {
        initiator_id: @initiator_id,
        user_code: @user_code
      }

      log_request(url, headers, query)

      response = HTTParty.get(
        url,
        headers: headers,
        query: query,
        verify: false
      )

      parsed_response = response.parsed_response

      log_response(response, parsed_response)

      parsed_response
    rescue StandardError => e
      Rails.logger.error "===== EKO DMT PROFILE ERROR ====="
      Rails.logger.error "#{e.class} => #{e.message}"
      Rails.logger.error e.backtrace.first(10).join("\n")

      {
        "status" => false,
        "message" => e.message
      }
    end

    private

    def generate_headers(timestamp)
      encoded_key = Base64.strict_encode64(@access_key)

      hmac = OpenSSL::HMAC.digest(
        "SHA256",
        encoded_key,
        timestamp
      )

      secret_key = Base64.strict_encode64(hmac)

      {
        "developer_key" => @developer_key,
        "secret-key-timestamp" => timestamp,
        "content-type" => "application/x-www-form-urlencoded",
        "secret-key" => secret_key
      }
    end

    def log_request(url, headers, query)
      Rails.logger.info "===== DMT PROFILE REQUEST START ====="
      Rails.logger.info "URL => #{url}"
      Rails.logger.info "Method => GET"
      Rails.logger.info "Query => #{query}"

      Rails.logger.info(
        "Headers => #{
          headers.merge("secret-key" => "************")
        }"
      )
    end

    def log_response(response, parsed_response)
      Rails.logger.info "Response Code => #{response.code}"
      Rails.logger.info "Raw Response => #{response.body}"
      Rails.logger.info "Parsed Response => #{parsed_response}"
      Rails.logger.info "===== DMT PROFILE REQUEST END ====="
    end
  end
end