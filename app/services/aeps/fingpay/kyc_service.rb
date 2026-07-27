# app/services/aeps/fingpay/kyc_service.rb

require "faraday"
require "json"
require "openssl"
require "base64"

module Aeps
  module Fingpay
    class KycService
      BASE_URL = "https://api.eko.in:25002".freeze
      ENDPOINT = "/ekoicici/v2/aeps/kyc".freeze

      def self.call(
        initiator_id:,
        user_code:,
        customer_id:,
        client_ref_id:,
        latlong:,
        reference_tid:,
        otp_ref_id:,
        bank_code:,
        ekyc_flag:,
        aadhar:,
        piddata:
      )

        Rails.logger.info("=" * 100)
        Rails.logger.info("KYC SERVICE STARTED")
        Rails.logger.info("=" * 100)

        payload = {
          initiator_id: initiator_id,
          user_code: user_code,
          customer_id: customer_id,
          client_ref_id: client_ref_id,
          latlong: latlong,
          reference_tid: reference_tid,
          otp_ref_id: otp_ref_id,
          bank_code: bank_code,
          ekyc_flag: ekyc_flag,
          aadhar: aadhar,
          piddata: piddata.to_s.strip
        }

        json_payload = JSON.generate(payload)

        current_timestamp = timestamp
        generated_secret_key = generate_secret_key(current_timestamp)

        headers = {
          "Content-Type"         => "application/json",
          "developer_key"        => ENV.fetch("EKO_DEV_KEY"),
          "secret-key"           => generated_secret_key,
          "secret-key-timestamp" => current_timestamp
        }

        Rails.logger.info("=" * 100)
        Rails.logger.info("REQUEST URL => #{BASE_URL}#{ENDPOINT}")
        Rails.logger.info("CUSTOMER ID => #{customer_id}")
        Rails.logger.info("USER CODE => #{user_code}")
        Rails.logger.info("BANK CODE => #{bank_code}")
        Rails.logger.info("LATLONG => #{latlong}")
        Rails.logger.info("EKYC FLAG => #{ekyc_flag}")
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

        connection = Faraday.new(
          url: BASE_URL,
          ssl: { verify: false }
        ) do |f|
          f.response :logger, Rails.logger, bodies: true
          f.adapter Faraday.default_adapter
        end

        response = connection.post(ENDPOINT) do |req|
          headers.each { |key, value| req.headers[key] = value }

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
          body: parse_response(response)
        }

      rescue StandardError => e

        Rails.logger.error("=" * 100)
        Rails.logger.error("ERROR CLASS => #{e.class}")
        Rails.logger.error("ERROR MESSAGE => #{e.message}")
        Rails.logger.error(e.backtrace.first(20).join("\n"))
        Rails.logger.error("=" * 100)

        {
          success: false,
          error: e.message
        }
      end

      private

      def self.generate_secret_key(timestamp)
        secret_key = ENV.fetch("EKO_SECRET_KEY")

        encoded_key = Base64.strict_encode64(secret_key)

        digest = OpenSSL::HMAC.digest(
          "sha256",
          encoded_key,
          timestamp.to_s
        )

        Base64.strict_encode64(digest)
      end

      def self.timestamp
        (Time.now.to_f * 1000).to_i.to_s
      end

      def self.parse_response(response)
        JSON.parse(response.body)
      rescue JSON::ParserError
        response.body
      end
    end
  end
end