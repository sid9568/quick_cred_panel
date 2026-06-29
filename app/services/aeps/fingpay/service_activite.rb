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

        body << "--#{boundary}\r\n"
        body << "Content-Disposition: form-data; name=\"form-data\"\r\n\r\n"
        body << payload
        body << "\r\n"

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

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        response = http.request(request)

        {
          code: response.code,
          headers: response.to_hash,
          body: response.body
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

        body << "--#{boundary}\r\n"
        body << "Content-Disposition: form-data; name=\"#{field_name}\"; filename=\"#{filename}\"\r\n"
        body << "Content-Type: #{content_type}\r\n\r\n"
        body << File.binread(path)
        body << "\r\n"
      end
    end
  end
end