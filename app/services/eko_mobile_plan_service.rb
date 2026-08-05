# app/services/eko_mobile_plan_service.rb
require 'base64'
require 'openssl'
require 'httparty'
require 'securerandom'

class EkoMobilePlanService
  BASE_URL = "https://api.eko.in:25002/ekoicici/v2/billpayments"

  def self.fetch_bill(dob:, operator_id:, utility_acc_no:, mobile_no:, sender_name:, client_ref_id: SecureRandom.hex(6))
    p "============mobile_no"
    p mobile_no
    user_code     = ENV["EKO_USER_CODE"]
    developer_key = ENV["EKO_DEV_KEY"]
    access_key    = ENV["EKO_SECRET_KEY"]
    initiator_id  = ENV["EKO_INITIATOR_ID"]

    # ---------------------------------------------------
    # 1️⃣ Timestamp
    # ---------------------------------------------------
    timestamp = (Time.now.to_f * 1000).to_i.to_s

    # ---------------------------------------------------
    # 2️⃣ SECRET-KEY
    # ---------------------------------------------------
    encoded_key = Base64.strict_encode64(access_key)
    hmac        = OpenSSL::HMAC.digest("SHA256", encoded_key, timestamp)
    secret_key  = Base64.strict_encode64(hmac)

    # 🔥 DEBUG LOGS (HEADER PART)
    puts "==================== EKO FETCH BILL DEBUG ===================="
    puts "TIMESTAMP               : #{timestamp}"
    puts "DEVELOPER KEY          : #{developer_key}"
    puts "USER CODE              : #{user_code}"
    puts "INITIATOR ID           : #{initiator_id}"
    puts "ACCESS KEY (RAW)       : #{access_key}"
    puts "ENCODED SECRET KEY     : #{encoded_key}"
    puts "HMAC SHA256            : #{hmac.unpack1('H*')}"
    puts "FINAL SECRET KEY (B64) : #{secret_key}"

    # ---------------------------------------------------
    # Headers
    # ---------------------------------------------------
    headers = {
      "developer_key"        => developer_key,
      "secret-key-timestamp" => timestamp,
      "secret-key"           => secret_key,
      "Content-Type"         => "application/json"
    }

    puts "\nHEADERS:"
    puts headers

    # ---------------------------------------------------
    # Payload
    # ---------------------------------------------------
    # payload = {
    #   source_ip: "121.121.1.1",
    #   user_code: user_code,
    #   client_ref_id: client_ref_id,
    #   utility_acc_no: utility_acc_no,
    #   confirmation_mobile_no: mobile_no,
    #   sender_name: sender_name,
    #   operator_id: operator_id,
    #   latlong: "28.6139,77.2090",
    #   hc_channel: "1"
    # }

    payload = if dob.present?
      {
        source_ip: "121.121.1.1",
        user_code: user_code,
        client_ref_id: client_ref_id,
        utility_acc_no: utility_acc_no,
        mobile_number: mobile_no,
        confirmation_mobile_no: mobile_no,
        sender_name: sender_name,
        operator_id: operator_id,
        dob7: dob,
        latlong: "28.6139,77.2090",
        hc_channel: "0"
      }
    else
      {
        source_ip: "121.121.1.1",
        user_code: user_code,
        client_ref_id: client_ref_id,
        consumer_number: utility_acc_no,
        utility_acc_no: utility_acc_no,
        mobile_number: mobile_no,
        confirmation_mobile_no: mobile_no,        # <---- required duplicate field
        sender_name: sender_name,
        operator_id: operator_id,
        latlong: "28.6139,77.2090",
        hc_channel: "0"
      }
    end

    puts "====== HEADERS ======"
    puts headers
    puts "====== PAYLOAD ======"
    puts payload.to_json

    # ---------------------------------------------------
    # URL
    # ---------------------------------------------------
    url = "#{BASE_URL}/fetchbill?initiator_id=#{initiator_id}"

    puts "\nURL:"
    puts url

    # ---------------------------------------------------
    # 6️⃣ API Call
    # ---------------------------------------------------
    response = HTTParty.post(
      url,
      headers: headers,
      body: payload.to_json,
      verify: false
    )

    # 🔥 RESPONSE LOG
    puts "\n==================== RESPONSE ===================="
    puts "RESPONSE CODE: #{response.code}"
    puts "RESPONSE BODY:\n#{response.body}"
    puts "===================================================\n\n"

    {
      success: response.code == 200,
      code: response.code,
      body: response.body
    }
  end
end
