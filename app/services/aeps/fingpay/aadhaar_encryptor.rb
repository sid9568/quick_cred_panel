# app/services/aeps/fingpay/aadhaar_encryptor.rb

require "openssl"
require "base64"

module Aeps
  module Fingpay
    class AadhaarEncryptor

      def self.encrypt(aadhaar_number)
        public_key_string = ENV.fetch("EKO_PUBLIC_KEY")

        decoded_key = Base64.decode64(public_key_string)

        public_key = OpenSSL::PKey::RSA.new(decoded_key)

        encrypted_data = public_key.public_encrypt(
          aadhaar_number,
          OpenSSL::PKey::RSA::PKCS1_PADDING
        )

        Base64.strict_encode64(encrypted_data)
      end
    end
  end
end