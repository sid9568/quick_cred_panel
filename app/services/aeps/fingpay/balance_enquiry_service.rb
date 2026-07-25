# app/services/aeps/fingpay/balance_enquiry_service.rb

require "faraday"
require "json"
require "openssl"
require "base64"
require "rexml/document"
require "rexml/formatters/default"

module Aeps
  module Fingpay
    class BalanceEnquiryService

      p "===============BalanceEnquiryService==================="

      BASE_URL = "https://api.eko.in:25002".freeze
      ENDPOINT = "/ekoicici/v3/customer/collection/aeps-fingpay/balance-enquiry".freeze

      # Same WADH value that you're using in TransactionService
      WADH_VALUE = ENV.fetch("EKO_WADH_VALUE")

      def initialize
        @developer_key = ENV.fetch("EKO_DEV_KEY")
        @secret_key    = ENV.fetch("EKO_SECRET_KEY")
      end

      def call(
        initiator_id:,
        user_code:,
        customer_id:,
        bank_code:,
        client_ref_id:,
        aadhar:,
        piddata:,
        latlong:
      )

        current_timestamp = timestamp

        encrypted_aadhar = encrypt_aadhaar(aadhar)
        processed_piddata = inject_wadh(piddata)

        payload = {
          initiator_id: "6268075916",
          client_ref_id: client_ref_id,
          user_code: user_code,
          bank_code: bank_code,
          aadhar: encrypted_aadhar,
          latlong: latlong,
          piddata: processed_piddata
        }

        Rails.logger.info("=" * 100)
        Rails.logger.info("BALANCE ENQUIRY REQUEST")
        Rails.logger.info(payload)

        response = connection(
          timestamp: current_timestamp,
          plain_aadhar: aadhar,
          user_code: user_code
        ).post("#{ENDPOINT}/#{customer_id}") do |req|
          req.body = payload.to_json
        end

        {
          success: response.success?,
          status: response.status,
          data: parse_response(response)
        }

      rescue StandardError => e
        Rails.logger.error("BALANCE ENQUIRY ERROR: #{e.message}")

        {
          success: false,
          error: e.message
        }
      end

      private

      def connection(timestamp:, plain_aadhar:, user_code:)

        secret_key = generate_secret_key(timestamp)

        request_hash = generate_request_hash(
          timestamp: timestamp,
          aadhar: plain_aadhar,
          user_code: user_code
        )

        Faraday.new(
          url: BASE_URL,
          ssl: { verify: false }
        ) do |f|
          f.headers["Content-Type"] = "application/json"
          f.headers["developer_key"] = @developer_key
          f.headers["secret-key"] = secret_key
          f.headers["secret-key-timestamp"] = timestamp
          f.headers["request_hash"] = request_hash

          f.response :logger, Rails.logger, bodies: true
          f.adapter Faraday.default_adapter
        end
      end

      def encrypt_aadhaar(aadhaar_number)

        Rails.logger.info("=" * 100)
        Rails.logger.info("AADHAAR => #{aadhaar_number}")

        raw_public_key = ENV.fetch("EKO_PUBLIC_KEY")

        der_bytes = Base64.decode64(raw_public_key)

        public_key = OpenSSL::PKey::RSA.new(der_bytes)

        encrypted = public_key.public_encrypt(
          aadhaar_number.to_s,
          OpenSSL::PKey::RSA::PKCS1_PADDING
        )

        Base64.strict_encode64(encrypted)
      end

      def inject_wadh(piddata)
        return piddata if piddata.blank?

        begin
          document = REXML::Document.new(piddata)
          pid_data = document.root

          return piddata unless pid_data

          wadh = pid_data.elements["wadh"]

          if wadh.nil?
            wadh = pid_data.add_element("wadh")
            wadh.text = WADH_VALUE
          elsif wadh.text.to_s.strip.empty?
            wadh.text = WADH_VALUE
          end

          xml_body = ""

          formatter = REXML::Formatters::Default.new
          formatter.write(pid_data, xml_body)

          if piddata.lstrip.start_with?("<?xml")
            declaration = piddata.split("?>", 2).first + "?>"
            "#{declaration}#{xml_body}"
          else
            xml_body
          end

        rescue REXML::ParseException
          piddata
        end
      end

      def generate_secret_key(timestamp)

        encoded_key = Base64.strict_encode64(@secret_key)

        digest = OpenSSL::HMAC.digest(
          "sha256",
          encoded_key,
          timestamp.to_s
        )

        Base64.strict_encode64(digest)
      end

      def generate_request_hash(
        timestamp:,
        aadhar:,
        user_code:
      )

        data = "#{timestamp}#{aadhar}#{user_code}"

        encoded_key = Base64.strict_encode64(@secret_key)

        digest = OpenSSL::HMAC.digest(
          "sha256",
          encoded_key,
          data
        )

        Base64.strict_encode64(digest)
      end

      def timestamp
        (Time.now.to_f * 1000).to_i.to_s
      end

      def parse_response(response)
        JSON.parse(response.body)
      rescue JSON::ParserError
        response.body
      end
    end
  end
end