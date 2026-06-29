require "net/http"
require "uri"
require "openssl"
require "base64"
require "json"
require "securerandom"
require "logger"

module Eko
  class AepsFingpayActivateService

    LOGGER = Logger.new($stdout)

    BASE_URL = "https://api.eko.in:25002/ekoicici/v3".freeze
    # Staging:
    # BASE_URL = "https://staging.eko.in:25004/ekoapi/v3".freeze

    def initialize(user_code:, initiator_id:, pan_card:, aadhar_front:, aadhar_back:)
      @user_code = user_code
      @initiator_id = initiator_id
      @pan_card = pan_card
      @aadhar_front = aadhar_front
      @aadhar_back = aadhar_back
    end

    def call
      timestamp = current_timestamp

      uri = URI(
        "#{BASE_URL}/admin/network/agent/#{@user_code}/aeps-fingpay/activate"
      )

      body, boundary = build_multipart_body

      request = Net::HTTP::Put.new(uri)

      request["developer_key"] = ENV.fetch("EKO_DEV_KEY")
      request["secret-key"] = generate_secret_key(timestamp)
      request["secret-key-timestamp"] = timestamp.to_s
      request["Accept"] = "application/json"
      request["Content-Type"] = "multipart/form-data; boundary=#{boundary}"

      request.body = body

      LOGGER.info("=" * 80)
      LOGGER.info("URL: #{uri}")
      LOGGER.info("METHOD: PUT")
      LOGGER.info("CONTENT_TYPE: #{request['Content-Type']}")
      LOGGER.info("USER_CODE: #{@user_code}")
      LOGGER.info("INITIATOR_ID: #{@initiator_id}")
      LOGGER.info("=" * 80)

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      response = http.request(request)

      LOGGER.info("=" * 80)
      LOGGER.info("STATUS: #{response.code}")
      LOGGER.info("BODY: #{response.body}")
      LOGGER.info("=" * 80)

      {
        code: response.code,
        body: response.body,
        headers: response.to_hash
      }
    rescue => e
      LOGGER.error(e.class.name)
      LOGGER.error(e.message)

      {
        error: e.class.name,
        message: e.message
      }
    end

    private

    def build_multipart_body
      boundary = "----WebKitFormBoundary#{SecureRandom.hex(16)}"
      body = +""

      add_text_part(body, boundary, "service_code", "43")
      add_text_part(body, boundary, "initiator_id", @initiator_id)
      add_text_part(body, boundary, "user_code", @user_code)
      add_text_part(body, boundary, "devicenumber", "123234234234234")
      add_text_part(body, boundary, "modelname", "Morpho")

      add_json_part(
        body,
        boundary,
        "office_address",
        office_address
      )

      add_json_part(
        body,
        boundary,
        "address_as_per_proof",
        address_as_per_proof
      )

      add_file_part(body, boundary, "pan_card", @pan_card)
      add_file_part(body, boundary, "aadhar_front", @aadhar_front)
      add_file_part(body, boundary, "aadhar_back", @aadhar_back)

      body << "--#{boundary}--\r\n"

      [body, boundary]
    end

    def add_text_part(body, boundary, name, value)
      body << "--#{boundary}\r\n"
      body << "Content-Disposition: form-data; name=\"#{name}\"\r\n\r\n"
      body << value.to_s
      body << "\r\n"
    end

    def add_json_part(body, boundary, name, payload)
      body << "--#{boundary}\r\n"
      body << "Content-Disposition: form-data; name=\"#{name}\"\r\n"
      body << "Content-Type: application/json\r\n\r\n"
      body << payload.to_json
      body << "\r\n"
    end

    def add_file_part(body, boundary, field_name, file_path)
      raise "File not found: #{file_path}" unless File.exist?(file_path)

      body << "--#{boundary}\r\n"
      body << "Content-Disposition: form-data; name=\"#{field_name}\"; filename=\"#{File.basename(file_path)}\"\r\n"
      body << "Content-Type: #{content_type(file_path)}\r\n\r\n"
      body << File.binread(file_path)
      body << "\r\n"
    end

    def office_address
      {
        line: "Eko India",
        city: "Gurgaon",
        state: "Haryana",
        pincode: "122002"
      }
    end

    def address_as_per_proof
      {
        line: "Eko India",
        city: "Gurgaon",
        state: "Haryana",
        pincode: "122002"
      }
    end

    def current_timestamp
      (Time.now.to_f * 1000).to_i
    end

    def generate_secret_key(timestamp)
      encoded_key = Base64.strict_encode64(
        ENV.fetch("EKO_SECRET_KEY")
      )

      signature = OpenSSL::HMAC.digest(
        "sha256",
        encoded_key,
        timestamp.to_s
      )

      Base64.strict_encode64(signature)
    end

    def content_type(path)
      case File.extname(path).downcase
      when ".jpg", ".jpeg"
        "image/jpeg"
      when ".png"
        "image/png"
      when ".pdf"
        "application/pdf"
      else
        "application/octet-stream"
      end
    end
  end
end