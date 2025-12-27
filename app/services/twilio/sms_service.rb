# app/services/twilio/sms_service.rb

require "twilio-ruby"

module Twilio
  class SmsService
    def initialize
      @client = ::Twilio::REST::Client.new(
        account_sid,
        auth_token
      )
    end

    def send_sms(to:, body:)
      raise "Messaging Service SID missing" if messaging_service_sid.blank?

      @client.messages.create(
        messaging_service_sid: messaging_service_sid,
        to: normalize_number(to),
        body: body
      )
    rescue ::Twilio::REST::TwilioError => e
      Rails.logger.error("[Twilio SMS Error] #{e.code} - #{e.message}")
      false
    end

    private

    def account_sid
      ENV.fetch("TWILIO_ACCOUNT_SID")
    end

    def auth_token
      ENV.fetch("TWILIO_AUTH_TOKEN")
    end

    def messaging_service_sid
      ENV.fetch("TWILIO_VERIFY_SERVICE_SID")
    end

    # Ensures +91 format
    def normalize_number(number)
      number.start_with?("+") ? number : "+91#{number}"
    end
  end
end