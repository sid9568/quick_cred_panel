require 'openssl'
require 'base64'
require 'net/http'
require 'json'

module Eko
  class DigilockerService
    def initialize
      @base_url = "https://api.eko.in:25002/ekoicici/v3"
      @developer_key = ENV['EKO_DEV_KEY']
      @access_key = ENV['EKO_SECRET_KEY']
    end

    def initiate_kyc(initiator_id:, user_code:, redirect_url:, client_ref_id:)
      timestamp = (Time.now.to_f * 1000).to_i.to_s
      secret_key = generate_secret_key(timestamp)

      uri = URI("#{@base_url}/tools/kyc/digilocker")

      headers = {
        "Content-Type" => "application/json",
        "developer_key" => @developer_key,
        "secret-key" => secret_key,
        "secret-key-timestamp" => timestamp
      }

      body = {
        initiator_id: initiator_id,
        user_code: user_code,
        document_requested: ["AADHAAR"],
        redirect_url: redirect_url,
        source: "API",
        client_ref_id: client_ref_id
      }

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.read_timeout = 30

      request = Net::HTTP::Post.new(uri.request_uri, headers)
      request.body = body.to_json

      response = http.request(request)

      parsed = JSON.parse(response.body)

      unless response.is_a?(Net::HTTPSuccess)
        raise "Eko DigiLocker Error: #{parsed}"
      end

      parsed
    end

    private

    def generate_secret_key(timestamp)
      encoded_key = Base64.strict_encode64(@access_key)
      digest = OpenSSL::HMAC.digest(
        OpenSSL::Digest.new('sha256'),
        encoded_key,
        timestamp
      )
      Base64.strict_encode64(digest)
    end
  end
end
