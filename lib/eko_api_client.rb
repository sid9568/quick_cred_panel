require "httparty"
require "openssl"
require "base64"
require "json"

class EkoApiClient
  STAGING_URL = "https://api.eko.in:25002/ekoicici/v1/user/service/activate"
  # EKO_DEV_KEY = 753595f07a59eb5a52341538fad5a63d
  # EKO_SECRET_KEY = 854313b5-a37a-445a-8bc5-a27f4f0fe56a
  # EKO_INITIATOR_ID = 9212094999
  # EKO_USER_CODE = 38130001
  def self.activate_service(params = {})
    # --- Required keys ---
    timestamp = (Time.now.to_f * 1000).to_i.to_s
    developer_key = ENV["EKO_DEV_KEY"]
    access_key    = ENV["EKO_SECRET_KEY"]     # authenticator password


    encoded_key = Base64.strict_encode64(access_key)
    secret_key_hmac = OpenSSL::HMAC.digest("SHA256", encoded_key, timestamp)
    secret_key = Base64.strict_encode64(secret_key_hmac)
    p "===========secret-key"
    p secret_key

    # --- Headers ---
    headers = {
      "developer_key" => developer_key,
      "secret-key" => secret_key,
      "secret-key-timestamp" => timestamp
    }

    # --- Validate files exist ---
    %i[pan_card aadhar_front aadhar_back].each do |file_key|
      raise "#{file_key} file not found: #{params[file_key]}" unless File.exist?(params[file_key])
    end

    # --- Body ---
    body = {
      "initiator_id" => params[:initiator_id],
      "user_code" => params[:user_code],
      "devicenumber" => params[:devicenumber],
      "modelname" => params[:modelname],
      "account" => params[:account],
      "ifsc" => params[:ifsc],
      "aadhar" => params[:aadhar],
      "shop_type" => params[:shop_type],
      "service_code" => params[:service_code],
      "latlong" => params[:latlong],
      "address_as_per_proof" => params[:address_as_per_proof], # send hash
      "office_address" => params[:office_address],             # send hash
      "pan_card" => File.open(params[:pan_card], "rb"),
      "aadhar_front" => File.open(params[:aadhar_front], "rb"),
      "aadhar_back" => File.open(params[:aadhar_back], "rb")
    }

    # --- Log request (mask secret-key) ---
    Rails.logger.info "===== Eko API Request ====="
    Rails.logger.info "URL: #{STAGING_URL}"
    Rails.logger.info "Headers: #{headers.except('secret-key')}"
    Rails.logger.info "Body keys: #{body}"
    Rails.logger.info "==========================="

    # --- Send request ---
    response = HTTParty.put(
      STAGING_URL,
      headers: headers,
      body: body,
      verify: false # Skip SSL verification for staging
    )

    # --- Log response ---
    Rails.logger.info "===== Eko API Response ====="
    Rails.logger.info "HTTP Code: #{response.code}"
    Rails.logger.info "Body: #{response.body}"
    Rails.logger.info "============================"

    response.parsed_response
  end
end
