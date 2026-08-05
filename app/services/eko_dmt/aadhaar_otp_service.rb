# frozen_string_literal: true

require 'httparty'
require 'openssl'
require 'base64'

module EkoDmt
  class AadhaarOtpService
    include HTTParty

    BASE_URL = 'https://api.eko.in:25002'

    def self.send_otp(
      initiator_id:,
      user_code:,
      aadhar:,
      access_key:,        # from Aadhaar Consent API
      realsourceip:,
      source: 'NEWCONNECT',
      is_consent: 'Y'
    )
      # ===========================
      # AUTH HEADER GENERATION
      # ===========================
      timestamp = (Time.now.to_f * 1000).to_i.to_s

      developer_key = ENV['EKO_DEV_KEY']
      authenticator = ENV['EKO_SECRET_KEY']

      raise 'EKO_DEV_KEY missing' if developer_key.blank?
      raise 'EKO_SECRET_KEY missing' if authenticator.blank?

      encoded_key = Base64.strict_encode64(authenticator)
      hmac        = OpenSSL::HMAC.digest('SHA256', encoded_key, timestamp)
      secret_key  = Base64.strict_encode64(hmac)

      headers = {
        'developer_key'        => developer_key,
        'secret-key'           => secret_key,
        'secret-key-timestamp' => timestamp,
        'Accept'               => 'application/json'
      }

      query = {
        source: source,
        initiator_id: initiator_id,
        user_code: user_code,
        aadhar: aadhar,
        is_consent: is_consent,
        access_key: access_key,
        caseId: aadhar,
        realsourceip: realsourceip
      }

      # ===========================
      # LOGGING (SAFE)
      # ===========================
      Rails.logger.info('[EKO][AADHAAR_OTP][REQUEST] ' \
        "initiator_id=#{initiator_id}, user_code=#{user_code}, " \
        "aadhaar=****#{aadhar[-4..]}, source=#{source}")

      response = get(
        "#{BASE_URL}/ekoicici/v2/external/getAdhaarOTP",
        headers: headers,
        query: query
      )

      Rails.logger.info('[EKO][AADHAAR_OTP][RESPONSE] ' \
        "http_status=#{response.code}, body=#{response.parsed_response}")

      {
        success: response.code == 200,
        status: response.code,
        body: response.parsed_response
      }
    rescue StandardError => e
      Rails.logger.error('[EKO][AADHAAR_OTP][ERROR] ' \
        "#{e.class}: #{e.message}")

      {
        success: false,
        error: e.message
      }
    end
  end
end
