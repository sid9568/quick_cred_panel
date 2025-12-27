class Api::V1::Agent::BeneficiariesController < Api::V1::Auth::BaseController

  def send_otp
    client.verify.v2
          .services(ENV["TWILIO_VERIFY_SERVICE_SID"])
          .verifications
          .create(
            to: normalized_mobile(params[:mobile]),
            channel: "sms"
          )

    render json: { message: "OTP sent successfully" }
  end

  def verify_otp
    otp = params[:otp].to_s.strip
    return render json: { error: "OTP required" }, status: :bad_request if otp.blank?

    result = client.verify.v2
                   .services(ENV["TWILIO_VERIFY_SERVICE_SID"])
                   .verification_checks
                   .create(
                     to: normalized_mobile(params[:mobile]),
                     code: otp
                   )

    Rails.logger.info "VERIFY STATUS => #{result.status}"

    if result.status == "approved"
      render json: { message: "OTP verified successfully" }
    else
      render json: { error: "Invalid or expired OTP" }, status: :unauthorized
    end
  end

  private

  def client
    @client ||= Twilio::REST::Client.new(
      ENV["TWILIO_ACCOUNT_SID"],
      ENV["TWILIO_AUTH_TOKEN"]
    )
  end

  def normalized_mobile(mobile)
    m = mobile.to_s.strip
    m.start_with?("+91") ? m : "+91#{m}"
  end
end
