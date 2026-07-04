# frozen_string_literal: true

require "httparty"
require "openssl"
require "base64"
require "json"

module Aeps
  module Fingpay
    class GetMccCategoryService
      include HTTParty

      base_uri "https://api.eko.in:25002"

      def initialize(initiator_id:, user_code:)
        @initiator_id = initiator_id
        @user_code = user_code
      end

      def call
        Rails.logger.info "================ EKO GET MCC CATEGORY START ================"
        Rails.logger.info "URL: #{self.class.base_uri}/ekoicici/v1/aeps/get-Mcc-Category"
        Rails.logger.info "Query: #{query_params.inspect}"
        Rails.logger.info "Headers: #{safe_headers.inspect}"

        response = self.class.get(
          "/ekoicici/v1/aeps/get-Mcc-Category",
          query: query_params,
          headers: headers
        )

        Rails.logger.info "Status Code: #{response.code}"
        Rails.logger.info "Response Body: #{response.body}"
        Rails.logger.info "================ EKO GET MCC CATEGORY END =================="

        {
          success: response.code == 200,
          status: response.code,
          body: parsed_response(response)
        }
      rescue StandardError => e
        Rails.logger.error "EKO GET MCC CATEGORY ERROR: #{e.message}"
        Rails.logger.error e.backtrace.join("\n")

        {
          success: false,
          status: 500,
          error: e.message
        }
      end

      private

      def query_params
        {
          initiator_id: @initiator_id,
          user_code: @user_code
        }
      end

      def headers
        access_key = ENV["EKO_SECRET_KEY"] || "d2fe1d99-6298-4af2-8cc5-d97dcf46df30"
        developer_key = ENV["EKO_DEV_KEY"] || "becbbce45f79c6f5109f848acd540567"

        timestamp = (Time.now.to_f * 1000).to_i.to_s
        encoded_key = Base64.strict_encode64(access_key)

        signature = OpenSSL::HMAC.digest(
          "SHA256",
          encoded_key,
          timestamp
        )

        secret_key = Base64.strict_encode64(signature)

        {
          "developer_key" => developer_key,
          "secret-key" => secret_key,
          "secret-key-timestamp" => timestamp,
          "Content-Type" => "application/x-www-form-urlencoded"
        }
      end

      def safe_headers
        headers.merge("secret-key" => "********")
      end

      def parsed_response(response)
        JSON.parse(response.body)
      rescue JSON::ParserError
        response.body
      end
    end
  end
end