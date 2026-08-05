# frozen_string_literal: true

require "net/http"
require "uri"
require "json"

module Otp
  class SmsDealNowProvider

    # ===========================
    # SEND OTP
    # ===========================
    def self.send_otp(mobile, full_name)
      Rails.logger.info "📩 [OTP-SEND] Request received for mobile: #{mobile}"

      mobile = mobile.to_s.last(10)

      user = VendorUser.find_or_initialize_by(phone_number: mobile) do |u|
        u.full_name = full_name
      end

      # ✅ BLOCK OTP IF ALREADY VERIFIED
      if user.persisted? && user.vendor_verify_status == true
        Rails.logger.info "ℹ️ [OTP-SEND] Vendor already verified for #{mobile}"

        return {
          success: true,
          message: "Sender already verified",
          vendor_verify_status: true,
          user: user
        }
      end

      # 🔹 Generate OTP
      otp = rand(100_000..999_999).to_s

      user.update!(
        otp: otp,
        vendor_expiry_otp: 10.minutes.from_now,
        vendor_verify_status: false
      )

      Rails.logger.info "✅ [OTP-SEND] OTP saved for user #{mobile}"

      message = "#{otp} is your OTP to add a new beneficiary. This OTP is valid for 10 minutes. Please do not share it. KWIKPE"
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

      Rails.logger.info "📡 [OTP-SEND] Sending SMS via SmsDealNow to #{mobile}"

      response = Net::HTTP.get_response(url)
      body = JSON.parse(response.body) rescue {}

      Rails.logger.info "📬 [OTP-SEND] Provider response: #{body}"

      code   = body.dig("RESPONSE", "CODE")
      status = body["STATUS"]

      success = %w[100 150].include?(code) && status == "OK"

      {
        success: success,
        message: success ? "OTP sent successfully" : "OTP sending failed",
        vendor_verify_status: false,
        provider: "smsdealnow",
        uid: body.dig("RESPONSE", "UID")
      }

    rescue => e
      Rails.logger.error "❌ [OTP-SEND] ERROR => #{e.message}"
      { success: false, error: e.message }
    end


    # ===========================
    # VERIFY OTP
    # ===========================
    def self.verify_otp(mobile, otp)
      Rails.logger.info "🔐 [OTP-VERIFY] Request received for mobile: #{mobile}"

      mobile = mobile.to_s.last(10)
      otp    = otp.to_s.strip

      user = VendorUser.find_by(phone_number: mobile)

      unless user
        Rails.logger.warn "⚠️ [OTP-VERIFY] User not found for #{mobile}"
        return { success: false, error: "Invalid OTP" }
      end

      unless user.otp.present?
        Rails.logger.warn "⚠️ [OTP-VERIFY] OTP missing for #{mobile}"
        return { success: false, error: "Invalid OTP" }
      end

      unless user.otp == otp
        Rails.logger.warn "❌ [OTP-VERIFY] OTP mismatch for #{mobile}"
        return { success: false, error: "Invalid OTP" }
      end

      user.update!(
        otp: nil,
        vendor_expiry_otp: nil,
        vendor_verify_status: true
      )

      Rails.logger.info "✅ [OTP-VERIFY] OTP verified successfully for #{mobile}"

      { success: true, user: user }

    rescue => e
      Rails.logger.error "❌ [OTP-VERIFY] ERROR => #{e.message}"
      { success: false, error: e.message }
    end

  end
end
