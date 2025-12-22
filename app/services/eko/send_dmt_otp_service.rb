# app/services/eko/send_dmt_otp_service.rb
module Eko
  class SendDmtOtpService
    include HTTParty

    BASE_URL = "https://staging.eko.in:25004/ekoapi/v3/customer/payment/dmt-fino/otp"

    def self.send_otp(params)
      timestamp     = (Time.now.to_f * 1000).to_i.to_s
      developer_key = ENV["EKO_DEV_KEY"] || "becbbce45f79c6f5109f848acd540567"
      access_key    = ENV["EKO_SECRET_KEY"] || "854313b5-a37a-445a-8bc5-a27f4f0fe56a"

      encoded_key = Base64.strict_encode64(access_key)
      hmac        = OpenSSL::HMAC.digest("SHA256", encoded_key, timestamp)
      secret_key  = Base64.strict_encode64(hmac)

      headers = {
        "developer_key"        => developer_key,
        "secret-key"           => secret_key,
        "secret-key-timestamp" => timestamp,
        "Content-Type"         => "application/json"
      }

      payload = {
        initiator_id: params[:initiator_id],   # "9212094999"
        user_code: params[:user_code],         # "38130001"
        amount: params[:amount],               # transfer amount
        recipient_id: params[:recipient_id],   # 116786565
        sender_mobile: params[:sender_mobile]  # "9999999999"
      }

      Rails.logger.info "======== EKO SEND OTP REQUEST ========"
      Rails.logger.info "URL: #{BASE_URL}"
      Rails.logger.info "HEADERS: #{headers}"
      Rails.logger.info "PAYLOAD: #{payload}"

      response = HTTParty.post(
        BASE_URL,
        headers: headers,
        body: payload.to_json,
        verify: false
      )

      Rails.logger.info "======== EKO SEND OTP RESPONSE ========"
      Rails.logger.info "STATUS: #{response.code}"
      Rails.logger.info "BODY: #{response.body}"

      response
    end
  end
end
