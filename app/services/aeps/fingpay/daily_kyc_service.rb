# app/services/aeps/fingpay/daily_kyc_service.rb

require "faraday"
require "json"
require "openssl"
require "base64"
require "rexml/document"


module Aeps
  module Fingpay
    class DailyKycService

      BASE_URL = "https://api.eko.in:25002".freeze

      PUBLIC_KEY = <<~KEY.delete("\n")
        MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCaFyrzeDhMaFLx+LZUNOOO14Pj9aPfr+1WOanDgDHxo9NekENYcWUftM9Y17ul2pXr3bqw0GCh4uxNoTQ5cTH4buI42LI8ibMaf7Kppq9MzdzI9/7pOffgdSn+P8J64CJAk3VrVswVgfy8lABt7fL8R6XReI9x8ewwKHhCRTwBgQIDAQAB
      KEY
      WADH_VALUE = ENV.fetch("EKO_WADH_VALUE").freeze

      def initialize
        @developer_key = ENV.fetch("EKO_DEV_KEY")
        @secret_key    = ENV.fetch("EKO_SECRET_KEY")
      end

      def call(
        initiator_id:,
        user_code:,
        customer_id:,
        client_ref_id:,
        latlong:,
        bank_code:,
        aadhar:,
        piddata:
      )

        encrypted_aadhar = encrypt_aadhar(aadhar)
        fixed_piddata = inject_wadh(piddata.to_s.strip)

        payload = {
          initiator_id: initiator_id,
          service_code: "43",
          user_code: user_code,
          customer_id: customer_id,
          client_ref_id: client_ref_id,
          latlong: latlong,
          bank_code: bank_code,
          aadhar: encrypted_aadhar,
          piddata: fixed_piddata
        }

        json_payload = JSON.generate(payload)

        current_timestamp = timestamp
        generated_secret_key = generate_secret_key(current_timestamp)

        Rails.logger.info("=" * 80)
        Rails.logger.info("EKO DAILY KYC REQUEST")
        Rails.logger.info("URL: #{BASE_URL}/ekoicici/v3/user/collection/aeps-fingpay/kyc/biometric/daily")
        Rails.logger.info("Headers:")
        Rails.logger.info({
          developer_key: @developer_key,
          secret_key: generated_secret_key,
          secret_key_timestamp: current_timestamp,
          content_type: "application/json"
        }.to_json)

        Rails.logger.info("Payload:")
        Rails.logger.info(JSON.pretty_generate(payload))
        Rails.logger.info("=" * 80)

        response = connection(current_timestamp, generated_secret_key).put(
          "/ekoicici/v3/user/collection/aeps-fingpay/kyc/biometric/daily"
        ) do |req|
          req.headers["Content-Type"] = "application/json"
          req.headers["Accept"] = "application/json"
          req.body = json_payload
        end
        

        Rails.logger.info("=" * 80)
        Rails.logger.info("EKO DAILY KYC RESPONSE")
        Rails.logger.info("HTTP Status: #{response.status}")
        Rails.logger.info("Headers: #{response.headers.to_h}")
        Rails.logger.info("Body:")
        Rails.logger.info(response.body)
        Rails.logger.info("=" * 80)

        {
          success: response.success?,
          status: response.status,
          data: parse_response(response)
        }
      end

      private

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
          # ✅ FIX: `document` (jisme XML declaration bhi shamil hota hai) ki jagah
          # sirf `pid_data` (root <PidData> element) pass karo. Pehle `document`
          # pass karne se REXML declaration + content dono serialize kar deta tha,
          # aur neeche wala code phir se declaration prepend karta tha — resulting
          # in a duplicated/malformed XML payload jo Eko ke server ko fail kara raha tha.
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

      def connection(current_timestamp, generated_secret_key)
        Faraday.new(
          url: BASE_URL,
          ssl: { verify: false }
        ) do |f|
          f.headers["developer_key"] = @developer_key
          f.headers["secret-key"] = generated_secret_key
          f.headers["secret-key-timestamp"] = current_timestamp
          f.headers["Content-Type"] = "application/json"
          f.adapter Faraday.default_adapter
        end
      end

      def encrypt_aadhar(aadhar_number)
        raise ArgumentError, "Aadhaar number is required" if aadhar_number.blank?

        key_bytes = Base64.decode64(PUBLIC_KEY)
        public_key = OpenSSL::PKey::RSA.new(key_bytes)

        encrypted_bytes = public_key.public_encrypt(
          aadhar_number.to_s.encode("UTF-8"),
          OpenSSL::PKey::RSA::PKCS1_PADDING
        )

        Base64.strict_encode64(encrypted_bytes)
      end

      def generate_secret_key(timestamp)
        encoded_key = Base64.strict_encode64(@secret_key)
        digest = OpenSSL::HMAC.digest("sha256", encoded_key, timestamp.to_s)
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