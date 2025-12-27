# frozen_string_literal: true

require "httparty"
require "openssl"
require "base64"

module EkoDmt
  class BankAccountVerifyService
    include HTTParty

    # ✅ Sandbox
    base_uri "https://api.eko.in:25002/ekoicici"
    # 🔁 Production
    # base_uri "https://api.eko.in:25002/ekoicici"

    def initialize(ifsc:, account_number:, initiator_id:, customer_id:, user_code:, client_ref_id:)
      @ifsc = ifsc.upcase
      @account_number = account_number
      @initiator_id = initiator_id
      @customer_id = customer_id
      @user_code = user_code
      @client_ref_id = client_ref_id
    end

    def call
      Rails.logger.info "================ EKO BANK VERIFY START ================"
      Rails.logger.info "Endpoint: #{endpoint_path}"
      Rails.logger.info "Headers: #{safe_headers.inspect}"
      Rails.logger.info "Body: #{body_params.inspect}"

      response = self.class.post(
        endpoint_path,
        headers: headers,
        body: body_params
      )

      Rails.logger.info "EKO Response Code: #{response.code}"
      Rails.logger.info "EKO Response Body: #{response.body}"
      Rails.logger.info "================ EKO BANK VERIFY END =================="

      response
    rescue StandardError => e
      Rails.logger.error "❌ EKO BANK VERIFY ERROR"
      Rails.logger.error e.message
      Rails.logger.error e.backtrace.join("\n")
      nil
    end

    private

    # ✅ EXACT ENDPOINT AS PER CURL
    # /v2/banks/ifsc:XXXX/accounts/YYYY
    def endpoint_path
      "/v2/banks/ifsc:#{@ifsc}/accounts/#{@account_number}"
    end

    # ✅ BODY (form-urlencoded)
    def body_params
      {
        initiator_id: @initiator_id,
        customer_id: @customer_id,
        user_code: @user_code,
        client_ref_id: @client_ref_id
      }
    end

    # 🔐 AUTH HEADERS (DYNAMIC)
    def headers
      access_key = ENV["EKO_SECRET_KEY"] || "d2fe1d99-6298-4af2-8cc5-d97dcf46df30"
      developer_key = ENV["EKO_DEV_KEY"] || "becbbce45f79c6f5109f848acd540567"

      timestamp = (Time.now.to_i * 1000).to_s
      encoded_key = Base64.strict_encode64(access_key)

      signature = OpenSSL::HMAC.digest("SHA256", encoded_key, timestamp)
      secret_key = Base64.strict_encode64(signature)

      {
        "developer_key" => developer_key,
        "secret-key" => secret_key,
        "secret-key-timestamp" => timestamp,
        "Content-Type" => "application/x-www-form-urlencoded"
      }
    end

    # 🔒 Mask secret-key in logs
    def safe_headers
      headers.merge("secret-key" => "****MASKED****")
    end
  end
end
