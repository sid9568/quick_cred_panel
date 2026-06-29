# app/services/aeps/fingpay/daily_kyc_service.rb

require "faraday"
require "json"
require "openssl"
require "base64"

module Aeps
  module Fingpay
    class DailyKycService

      BASE_URL = "https://api.eko.in:25002".freeze

      PUBLIC_KEY = <<~KEY.delete("\n")
        MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCaFyrzeDhMaFLx+LZUNOOO14Pj9aPfr+1WOanDgDHxo9NekENYcWUftM9Y17ul2pXr3bqw0GCh4uxNoTQ5cTH4buI42LI8ibMaf7Kppq9MzdzI9/7pOffgdSn+P8J64CJAk3VrVswVgfy8lABt7fL8R6XReI9x8ewwKHhCRTwBgQIDAQAB
      KEY

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

        Rails.logger.info("=" * 100)
        Rails.logger.info("DAILY KYC SERVICE STARTED")
        Rails.logger.info("=" * 100)

        encrypted_aadhar = encrypt_aadhar(aadhar)

        payload = {
          initiator_id: initiator_id,
          service_code: "43",
          user_code: user_code,
          customer_id: customer_id,
          client_ref_id: client_ref_id,
          latlong: latlong,
          bank_code: bank_code,
          aadhar: encrypted_aadhar,
          piddata: piddata.to_s.strip
        }

        json_payload = JSON.generate(payload)

        Rails.logger.info("=" * 100)
        Rails.logger.info("REQUEST URL => #{BASE_URL}/ekoicici/v2/aeps/dailyKyc")
        Rails.logger.info("CUSTOMER ID => #{customer_id}")
        Rails.logger.info("USER CODE => #{user_code}")
        Rails.logger.info("BANK CODE => #{bank_code}")
        Rails.logger.info("LATLONG => #{latlong}")
        Rails.logger.info("SERVICE CODE => 43")
        Rails.logger.info("AADHAAR ENCRYPTED LENGTH => #{encrypted_aadhar.length}")
        Rails.logger.info("=" * 100)

        Rails.logger.info("PID XML START")
        Rails.logger.info(piddata.to_s)
        Rails.logger.info("PID XML END")

        begin
          Rails.logger.info("PIDDATA LENGTH => #{piddata.to_s.length}")

          if piddata.to_s.include?("<Resp")
            err_code = piddata[/errCode="([^"]+)"/, 1]
            err_info = piddata[/errInfo="([^"]+)"/, 1]

            Rails.logger.info("PID ERR CODE => #{err_code}")
            Rails.logger.info("PID ERR INFO => #{err_info}")
          end

          if piddata.to_s.include?("<DeviceInfo")
            dp_id = piddata[/dpId="([^"]+)"/, 1]
            dc    = piddata[/dc="([^"]+)"/, 1]
            mi    = piddata[/mi="([^"]+)"/, 1]

            Rails.logger.info("DEVICE DPID => #{dp_id}")
            Rails.logger.info("DEVICE DC => #{dc}")
            Rails.logger.info("DEVICE MI => #{mi}")
          end

        rescue => e
          Rails.logger.error("PIDDATA PARSE ERROR => #{e.message}")
        end

        Rails.logger.info("=" * 100)
        Rails.logger.info("REQUEST PAYLOAD")
        Rails.logger.info(json_payload)
        Rails.logger.info("=" * 100)

        response = connection.post("/ekoicici/v2/aeps/dailyKyc") do |req|
          req.headers["Content-Type"] = "application/json"
          req.body = json_payload
        end

        Rails.logger.info("=" * 100)
        Rails.logger.info("RESPONSE STATUS => #{response.status}")
        Rails.logger.info("RESPONSE HEADERS => #{response.headers}")
        Rails.logger.info("RESPONSE BODY => #{response.body}")

        begin
          parsed = JSON.parse(response.body)

          Rails.logger.info("EKO RESPONSE STATUS => #{parsed['status']}")
          Rails.logger.info("EKO RESPONSE TYPE => #{parsed['response_type_id']}")
          Rails.logger.info("EKO RESPONSE MESSAGE => #{parsed['message']}")

          if parsed["data"].present?
            Rails.logger.info("EKO RESPONSE DATA => #{parsed['data'].inspect}")
          end

        rescue => e
          Rails.logger.error("RESPONSE PARSE ERROR => #{e.message}")
        end

        Rails.logger.info("=" * 100)

        {
          success: response.success?,
          status: response.status,
          data: parse_response(response)
        }

      rescue StandardError => e

        Rails.logger.error("=" * 100)
        Rails.logger.error("ERROR CLASS => #{e.class}")
        Rails.logger.error("ERROR MESSAGE => #{e.message}")
        Rails.logger.error(e.backtrace.first(20).join("\n"))
        Rails.logger.error("=" * 100)

        {
          success: false,
          message: e.message
        }
      end

      private

      def connection
        current_timestamp = timestamp
        generated_secret_key = generate_secret_key(current_timestamp)

        Rails.logger.info("=" * 100)
        Rails.logger.info("DEVELOPER KEY => #{@developer_key}")
        Rails.logger.info("TIMESTAMP => #{current_timestamp}")
        Rails.logger.info("SECRET KEY => #{generated_secret_key}")
        Rails.logger.info("=" * 100)

        Faraday.new(
          url: BASE_URL,
          ssl: { verify: false }
        ) do |f|

          f.headers["developer_key"] = @developer_key
          f.headers["secret-key"] = generated_secret_key
          f.headers["secret-key-timestamp"] = current_timestamp
          f.headers["Content-Type"] = "application/json"

          f.response :logger, Rails.logger, bodies: true

          f.adapter Faraday.default_adapter
        end
      end

      def encrypt_aadhar(aadhar_number)
        Rails.logger.info("PLAIN AADHAAR => #{aadhar_number}")

        der_bytes  = Base64.decode64(PUBLIC_KEY)
        asn1       = OpenSSL::ASN1.decode(der_bytes)
        public_key = OpenSSL::PKey::RSA.new(asn1.to_der)

        encrypted = public_key.public_encrypt(
          aadhar_number.to_s,
          OpenSSL::PKey::RSA::PKCS1_PADDING
        )

        encrypted_aadhar = Base64.strict_encode64(encrypted)

        Rails.logger.info("ENCRYPTED AADHAAR => #{encrypted_aadhar}")
        Rails.logger.info("AADHAAR LENGTH => #{encrypted_aadhar.length}")

        encrypted_aadhar
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