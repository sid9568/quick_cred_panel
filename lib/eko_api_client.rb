# frozen_string_literal: true

require "httparty"
require "openssl"
require "base64"

class EkoApiClient
  include HTTParty

  STAGING_URL = "https://api.eko.in:25002/ekoicici/v1/user/service/activate"

  def self.activate_service(params = {})
    timestamp     = (Time.now.to_f * 1000).to_i.to_s
    developer_key = ENV.fetch("EKO_DEV_KEY")
    access_key    = ENV.fetch("EKO_SECRET_KEY")

    # ---- Generate secret-key (HMAC) ----
    encoded_key = Base64.strict_encode64(access_key)
    hmac        = OpenSSL::HMAC.digest("SHA256", encoded_key, timestamp)
    secret_key  = Base64.strict_encode64(hmac)

    # ---- Headers (EXACT curl match) ----
    headers = {
      "developer_key"        => developer_key,
      "secret-key"           => secret_key,
      "secret-key-timestamp" => timestamp,
      "Content-Type"         => "application/x-www-form-urlencoded"
      # ❌ Cookie not required (curl me auto aa jata hai)
    }

    # ---- Body (x-www-form-urlencoded ONLY) ----
    body = {
      service_code: params[:service_code], # 58
      initiator_id: params[:initiator_id], # 9962981729
      user_code:    params[:user_code],    # 20810200
      latlong:      params[:latlong]       # "77.06794760,77.06794760"
    }

    # ---- Logs (safe) ----
    Rails.logger.info "[EKO][ActivateService][REQUEST] url=#{STAGING_URL}"
    Rails.logger.info "[EKO][ActivateService][HEADERS] #{headers.except('secret-key')}"
    Rails.logger.info "[EKO][ActivateService][BODY] #{body}"

    response = HTTParty.put(
      STAGING_URL,
      headers: headers,
      body: body
    )

    Rails.logger.info "[EKO][ActivateService][RESPONSE] code=#{response.code}"
    Rails.logger.info "[EKO][ActivateService][RESPONSE] body=#{response.body}"

    response
  rescue StandardError => e
    Rails.logger.error "[EKO][ActivateService][ERROR] #{e.class} - #{e.message}"
    raise
  end
end
