# frozen_string_literal: true

require "httparty"

module Finpass
  class CibilScoreService
    include HTTParty

    base_uri "https://api.finpass.ai"

    API_KEY = ENV.fetch("FINPASS_API_KEY")
    API_SECRET = ENV.fetch("FINPASS_API_SECRET")

    def initialize(pan:, name:, mobile_number:, consent:, gender:, bureaus:)
      @pan = pan
      @name = name
      @mobile_number = mobile_number
      @consent = consent
      @gender = gender
      @bureaus = bureaus
    end

    def call
      self.class.post(
        "/api/v1/services/multi-bureau/fetch",
        headers: headers,
        body: payload.to_json
      )
    rescue StandardError => e
      Rails.logger.error "Finpass CIBIL API Error: #{e.message}"
      {
        success: false,
        message: e.message
      }
    end

    private

    def headers
      {
        "X-API-Key" => API_KEY,
        "X-API-Secret" => API_SECRET,
        "Content-Type" => "application/json"
      }
    end

    def payload
      {
        pan: @pan,
        name: @name,
        mobile_number: @mobile_number,
        consent: @consent,
        gender: @gender,
        bureaus: @bureaus
      }
    end
  end
end