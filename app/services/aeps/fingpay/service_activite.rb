# app/services/aeps/fingpay/service_activite.rb

require "net/http"
require "uri"
require "openssl"
require "base64"
require "json"
require "securerandom"

module Aeps
  module Fingpay
    class ServiceActivite
      def self.activate_fingpay_service(
        user_code:,
        initiator_id:,
        devicenumber:,
        modelname:,
        account:,
        ifsc:,
        aadhar:,
        shop_type:,
        service_code:,
        latlong:,
        address_as_per_proof:,
        office_address:,
        pan_card:,
        aadhar_front:,
        aadhar_back:
      )

        Rails.logger.info "================ EKO SERVICE ACTIVATE START ================"

        developer_key = ENV.fetch("EKO_DEV_KEY")
        access_key    = ENV.fetch("EKO_SECRET_KEY")

        timestamp = (Time.now.to_f * 1000).to_i.to_s

        encoded_key = Base64.strict_encode64(access_key)

        hmac = OpenSSL::HMAC.digest(
          "sha256",
          encoded_key,
          timestamp
        )

        secret_key = Base64.strict_encode64(hmac)

        uri = URI("https://api.eko.in:25002/ekoicici/v1/user/service/activate")

        Rails.logger.info "URL: #{uri}"

        boundary = "----WebKitFormBoundary#{SecureRandom.hex(16)}"

        body = +"".b

        payload =
          "initiator_id=#{initiator_id}" \
          "&user_code=#{user_code}" \
          "&devicenumber=#{devicenumber}" \
          "&modelname=#{modelname}" \
          "&account=#{account}" \
          "&ifsc=#{ifsc}" \
          "&aadhar=#{aadhar}" \
          "&shop_type=#{shop_type}" \
          "&service_code=#{service_code}" \
          "&latlong=#{latlong}" \
          "&address_as_per_proof=#{address_as_per_proof.to_json}" \
          "&office_address=#{office_address.to_json}"

        Rails.logger.info "Payload: #{payload}"

        body << "--#{boundary}\r\n"
        body << "Content-Disposition: form-data; name=\"form-data\"\r\n\r\n"
        body << payload
        body << "\r\n"

        Rails.logger.info "PAN Card: #{pan_card}"
        Rails.logger.info "Aadhar Front: #{aadhar_front}"
        Rails.logger.info "Aadhar Back: #{aadhar_back}"

        append_file(body, boundary, "pan_card", pan_card)
        append_file(body, boundary, "aadhar_front", aadhar_front)
        append_file(body, boundary, "aadhar_back", aadhar_back)

        body << "--#{boundary}--\r\n"

        request = Net::HTTP::Put.new(uri)

        request["Cache-Control"] = "no-cache"
        request["developer_key"] = developer_key
        request["secret-key"] = secret_key
        request["secret-key-timestamp"] = timestamp
        request["Content-Type"] = "multipart/form-data; boundary=#{boundary}"

        request.body = body

        Rails.logger.info "Headers:"
        Rails.logger.info({
          "developer_key" => developer_key,
          "secret-key" => "************",
          "secret-key-timestamp" => timestamp,
          "Content-Type" => "multipart/form-data; boundary=#{boundary}"
        }.inspect)

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        response = http.request(request)

        Rails.logger.info "Response Code: #{response.code}"
        Rails.logger.info "Response Headers: #{response.to_hash.inspect}"
        Rails.logger.info "Response Body: #{response.body}"

        Rails.logger.info "================ EKO SERVICE ACTIVATE END =================="

        {
          code: response.code,
          headers: response.to_hash,
          body: response.body
        }

      rescue StandardError => e
        Rails.logger.error "================ EKO SERVICE ACTIVATE ERROR ================"
        Rails.logger.error "Error: #{e.message}"
        Rails.logger.error e.backtrace.join("\n")

        {
          code: 500,
          headers: {},
          body: {
            success: false,
            error: e.message
          }.to_json
        }
      end

      def self.append_file(body, boundary, field_name, path)
        raise "File not found: #{path}" unless File.exist?(path)

        filename = File.basename(path)

        content_type =
          case File.extname(filename).downcase
          when ".jpg", ".jpeg"
            "image/jpeg"
          when ".png"
            "image/png"
          when ".pdf"
            "application/pdf"
          else
            "application/octet-stream"
          end

        Rails.logger.info "Attaching #{field_name}: #{filename} (#{content_type})"

        body << "--#{boundary}\r\n".b
        body << "Content-Disposition: form-data; name=\"#{field_name}\"; filename=\"#{filename}\"\r\n".b
        body << "Content-Type: #{content_type}\r\n\r\n".b
        body << File.binread(path)
        body << "\r\n".b
      end
      
    end
  end
end