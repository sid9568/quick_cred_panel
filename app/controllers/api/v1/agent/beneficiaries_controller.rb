class Api::V1::Agent::BeneficiariesController < Api::V1::Auth::BaseController

  def send_otp
    result = Otp::SmsDealNowProvider.send_otp(params[:mobile])
    p "========result============"
    p result
    render json: result
  end

  def verify_otp
    p "============herreee"
    result = Otp::SmsDealNowProvider.verify_otp(
      params[:mobile],
      params[:otp]
    )
    render json: result
  end

end
