require "openssl"
require "base64"
require "net/http"
require "json"

class AepsService
  BASE_URL       = ENV.fetch("EKO_BASE_URL",       "https://staging.eko.in:25004")
  AEPS_ENDPOINT  = "/ekoapi/v2/aeps"
  DEVELOPER_KEY  = ENV.fetch("EKO_DEVELOPER_KEY",  "becbbce45f79c6f5109f848acd540567")
  SECRET_KEY_RAW = ENV.fetch("EKO_SECRET_KEY_RAW", "d2fe1d99-6298-4af2-8cc5-d97dcf46df30")
  INITIATOR_ID   = ENV.fetch("EKO_INITIATOR_ID",   "9962981729")

  AADHAAR_PUBLIC_KEY_PEM = <<~PEM.freeze
    MIGfMA0GCSqGSIb3DQEBaqUAA4GNADCBiQKBgQCaFyrzeDhMaFLx+LZUNOO
    O14Pj9aPfr+1WOanDgDHxo9NekENYcWUftM9Y17ul2pXr3bqw0GCh4uxNoTQ5
    cTH4buI42LI8ibMaf7Kppq9Mzdzl9/7pOffgdSn+P8J64CJAk3VrVswVgfy8lABt7fL
    8R6XReI9x8ewwKHhCRTwBgQIDAQAB
  PEM

  def aeps(customer_id:, bank_code:, amount:, raw_aadhaar:, piddata:,
           user_code:, client_ref_id:, pipe: "0", notify_customer: "0")
    encrypted_aadhar = encrypt_aadhaar(raw_aadhaar)
    timestamp        = generate_timestamp
    headers          = build_headers(timestamp, raw_aadhaar: raw_aadhaar, amount: amount.to_s, user_code: user_code)

    body = {
      service_type:    2,
      initiator_id:    INITIATOR_ID,
      user_code:       user_code,
      customer_id:     customer_id,
      bank_code:       bank_code,
      amount:          amount.to_s,
      client_ref_id:   client_ref_id,
      pipe:            pipe,
      aadhar:          encrypted_aadhar,
      notify_customer: notify_customer,
      piddata:         piddata
    }

    post(AEPS_ENDPOINT, body, headers)
  end

  private

  def encrypt_aadhaar(raw_aadhaar_number)
    public_key = load_rsa_public_key(AADHAAR_PUBLIC_KEY_PEM)
    encrypted  = public_key.public_encrypt(raw_aadhaar_number.to_s, OpenSSL::PKey::RSA::PKCS1_PADDING)
    Base64.strict_encode64(encrypted)
  end

  def build_headers(timestamp, raw_aadhaar:, amount:, user_code:)
    secret_key   = generate_secret_key(timestamp)
    request_hash = generate_request_hash(timestamp, raw_aadhaar, amount, user_code)

    {
      "Content-Type"         => "application/json",
      "developer_key"        => DEVELOPER_KEY,
      "secret-key"           => secret_key,
      "secret-key-timestamp" => timestamp,
      "request_hash"         => request_hash
    }
  end

  def generate_secret_key(timestamp)
    encoded_key    = Base64.strict_encode64(SECRET_KEY_RAW)
    hmac_signature = OpenSSL::HMAC.digest("SHA256", encoded_key, timestamp)
    Base64.strict_encode64(hmac_signature)
  end

  def generate_request_hash(timestamp, raw_aadhaar, amount, user_code)
    data        = "#{timestamp}#{raw_aadhaar}#{amount}#{user_code}"
    encoded_key = Base64.strict_encode64(SECRET_KEY_RAW)
    signature   = OpenSSL::HMAC.digest("SHA256", encoded_key, data)
    Base64.strict_encode64(signature)
  end

  def generate_timestamp
    (Time.now.to_f * 1000).to_i.to_s
  end

  def load_rsa_public_key(pem_string)
    clean_b64 = pem_string.gsub(/\s+/, "")
    key_bytes = Base64.decode64(clean_b64)
    OpenSSL::PKey::RSA.new(OpenSSL::ASN1.decode(key_bytes).to_der)
  rescue OpenSSL::PKey::RSAError => e
    raise "Failed to load Aadhaar public key: #{e.message}"
  end

  def post(path, body, headers)
    uri              = URI("#{BASE_URL}#{path}")
    http             = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl     = uri.scheme == "https"
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    request      = Net::HTTP::Post.new(uri.path, headers)
    request.body = body.to_json

    response = http.request(request)
    parse_response(response)
  rescue Net::OpenTimeout, Net::ReadTimeout => e
    { success: false, error: "Request timed out: #{e.message}" }
  rescue StandardError => e
    { success: false, error: "HTTP error: #{e.message}" }
  end

  def parse_response(response)
    parsed = JSON.parse(response.body)
    { success: response.code.to_i == 200, http_status: response.code.to_i, data: parsed }
  rescue JSON::ParserError
    { success: false, http_status: response.code.to_i, raw_body: response.body, error: "Invalid JSON response" }
  end
end