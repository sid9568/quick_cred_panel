# frozen_string_literal: true

require "base64"
require "openssl"
require "httparty"

module Eko
  class TransactionService
    include HTTParty

    BASE_BY_TXN_ID     = "https://api.eko.in:25002/ekoicici/v1"
    BASE_BY_CLIENT_REF = "https://api.eko.in:25002/ekoicici/v1"

    format :json

    def initialize
      @developer_key = ENV.fetch("EKO_DEV_KEY")
      @access_key   = ENV.fetch("EKO_SECRET_KEY")
      @logger       = Rails.logger
    end

    # transaction_id OR client_ref_id (any one required)
    def fetch(transaction_id: nil, client_ref_id: nil, initiator_id:)
      if transaction_id.blank? && client_ref_id.blank?
        raise ArgumentError, "transaction_id or client_ref_id is required"
      end

      timestamp = current_timestamp
      headers   = build_headers(timestamp)

      url, query = build_request(transaction_id, client_ref_id, initiator_id)

      log_request(url, query, headers)

      response = self.class.get(
        url,
        headers: headers.merge("Content-Type" => nil), # GET safety
        query: query
      )

      log_response(response)
      response
    rescue StandardError => e
      @logger.error("[EKO][TransactionService][ERROR] #{e.class} - #{e.message}")
      raise
    end

    private

    def build_request(transaction_id, client_ref_id, initiator_id)
      if transaction_id.present?
        [
          "#{BASE_BY_TXN_ID}/transactions/#{transaction_id}",
          { initiator_id: initiator_id }
        ]
      else
        [
          "#{BASE_BY_CLIENT_REF}/transactions/client_ref_id:#{client_ref_id}",
          {} # no query params required
        ]
      end
    end

    def current_timestamp
      (Time.now.to_f * 1000).to_i.to_s
    end

    def build_headers(timestamp)
      encoded_key = Base64.strict_encode64(@access_key)
      hmac        = OpenSSL::HMAC.digest("SHA256", encoded_key, timestamp)
      secret_key  = Base64.strict_encode64(hmac)

      {
        "developer_key"        => @developer_key,
        "secret-key"           => secret_key,
        "secret-key-timestamp" => timestamp
      }
    end

    # ---------- Logging helpers ----------

    def masked_headers(headers)
      headers.merge(
        "secret-key" => "****#{headers['secret-key']&.last(4)}"
      )
    end

    def log_request(url, query, headers)
      @logger.info(
        "[EKO][TransactionService][REQUEST] " \
        "url=#{url}, query=#{query}, headers=#{masked_headers(headers)}"
      )
    end

    def log_response(response)
      @logger.info(
        "[EKO][TransactionService][RESPONSE] " \
        "code=#{response.code}, body=#{response.body}"
      )
    end
  end
end
