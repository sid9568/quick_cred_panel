# frozen_string_literal: true

require "net/http"
require "uri"
require "json"

module Otp
  class SmsDealNowProvider

    # ===========================
    # SEND OTP
    # ===========================
    def self.send_otp(mobile)
      mobile = mobile.to_s.last(10)
      otp = rand(100_000..999_999).to_s

      role = Role.find_by(title: "vendor")
      return { success: false, error: "Vendor role missing" } unless role

      user = User.find_or_initialize_by(phone_number: mobile)

      user.role_id = role.id
      user.vendor_otp = otp
      user.vendor_expiry_otp = 10.minutes.from_now
      user.vendor_verify_status = false
      user.save!

      message = "#{otp} is your OTP to add a new beneficiary. " \
        "This OTP is valid for 10 minutes. Do not share it. KWIKPE"

      encoded_msg = URI.encode_www_form_component(message)

      url = URI.parse(
        "http://smsdealnow.com/api/pushsms" \
        "?user=#{ENV['SMSDEALNOW_USER']}" \
        "&authkey=#{ENV['SMSDEALNOW_AUTH_KEY']}" \
        "&sender=#{ENV['SMSDEALNOW_SENDER_ID']}" \
        "&mobile=91#{mobile}" \
        "&text=#{encoded_msg}" \
        "&entityid=#{ENV['SMSDEALNOW_ENTITY_ID']}" \
        "&templateid=#{ENV['SMSDEALNOW_TEMPLATE_ID']}" \
        "&rpt=1"
      )

      response = Net::HTTP.get_response(url)
      body = JSON.parse(response.body) rescue {}

      code   = body.dig("RESPONSE", "CODE")
      status = body["STATUS"]

      success = %w[100 150].include?(code) && status == "OK"

      {
        success: success,
        provider: "smsdealnow",
        uid: body.dig("RESPONSE", "UID")
      }

    rescue => e
      Rails.logger.error "❌ OTP SEND ERROR => #{e.message}"
      { success: false, error: e.message }
    end


    # ===========================
    # VERIFY OTP
    # ===========================
    def self.verify_otp(mobile, otp)
      mobile = mobile.to_s.last(10)
      otp    = otp.to_s.strip
      p "=======mobile========"
      p mobile
      user = User.find_by(phone_number: mobile)
      p "======user==========="
      p user.vendor_otp
      p "====otp========"
      p otp

      return { success: false, error: "Invalid OTP" } unless user
      return { success: false, error: "Invalid OTP" } unless user.vendor_otp.present?
      return { success: false, error: "Invalid OTP" } unless user.vendor_otp == otp

      # # 🔐 Safe expiry check
      # if user.otp_expires_at.nil? || user.otp_expires_at < Time.current
      #   return { success: false, error: "OTP expired" }
      # end

      user.update!(
        vendor_otp: nil,
        vendor_expiry_otp: nil,
        vendor_verify_status: true
      )

      { success: true, user: user }

    rescue => e
      Rails.logger.error "❌ OTP VERIFY ERROR => #{e.message}"
      { success: false, error: e.message }
    end


  end
end
