require "openssl"
require "base64"

module Aeps
  module Fingpay
    class AadhaarEncryptor

      def self.encrypt(aadhaar_number)
        raise ArgumentError, "Aadhaar is required" if aadhaar_number.blank?

        public_key_string = ENV.fetch("EKO_PUBLIC_KEY")

        Rails.logger.info("=" * 80)
        Rails.logger.info("AADHAAR => #{aadhaar_number}")
        Rails.logger.info("PUBLIC KEY LENGTH => #{public_key_string.length}")

        key_bytes = Base64.decode64(public_key_string)

        public_key = OpenSSL::PKey::RSA.new(key_bytes)

        encrypted_bytes = public_key.public_encrypt(
          aadhaar_number.to_s.encode("UTF-8"),
          OpenSSL::PKey::RSA::PKCS1_PADDING
        )

        encrypted_aadhaar = Base64.strict_encode64(encrypted_bytes)

        Rails.logger.info("ENCRYPTED LENGTH => #{encrypted_aadhaar.length}")
        Rails.logger.info("ENCRYPTED => #{encrypted_aadhaar}")

        encrypted_aadhaar
      rescue => e
        Rails.logger.error(e.full_message)
        raise
      end
    end
  end
end