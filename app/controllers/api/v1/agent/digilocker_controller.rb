class Api::V1::Agent::DigilockerController < Api::V1::Auth::BaseController

  def initiate
    mobile_no = params[:mobile_number]
    vendor_user = VendorUser.find_by(phone_number: mobile_no)

    return render json: {
      success: false,
      message: "User not found"
    }, status: 404 unless vendor_user

    if vendor_user.addhar_kyc_status
      return render json: {
        success: true,
        message: "Aadhaar KYC already completed"
      }, status: 200
    end

    service = Eko::DigilockerService.new

    result = service.initiate_kyc(
      initiator_id: "9212094999",
      user_code: "38130001",
      redirect_url: params[:redirect_url],
      client_ref_id: params[:client_ref_id]
    )

    Rails.logger.info "Digilocker Response: #{result}"

    # ✅ IMPORTANT FIX
    if result.dig("data", "status") == 0
      vendor_user.update!(addhar_kyc_status: true)
    end

    render json: {
      success: true,
      data: result
    }, status: 200

  rescue => e
    render json: {
      success: false,
      error: e.message
    }, status: 500
  end



end
