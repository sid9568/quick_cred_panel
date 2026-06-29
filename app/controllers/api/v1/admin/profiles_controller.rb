# app/controllers/api/v1/admin/profiles_controller.rb

class Api::V1::Admin::ProfilesController < Api::V1::Auth::BaseController

  def index
    render json: {
      success: true,
      data: current_user
    }, status: :ok
  end

  def update
  update_params = profile_params.to_h

  if params[:aadhaar_image].present?
    update_params[:aadhaar_image] = Cloudinary::Uploader.upload(
      params[:aadhaar_image],
      folder: "users/aadhaar"
    )["secure_url"]
  end

  if params[:pan_card_image].present?
    update_params[:pan_card_image] = Cloudinary::Uploader.upload(
      params[:pan_card_image],
      folder: "users/pan"
    )["secure_url"]
  end

  if params[:store_shop_photo].present?
    update_params[:store_shop_photo] = Cloudinary::Uploader.upload(
      params[:store_shop_photo],
      folder: "users/store"
    )["secure_url"]
  end

  if current_user.update(update_params)
    render json: {
      success: true,
      message: "Profile updated successfully",
      data: current_user
    }, status: :ok
  else
    render json: {
      success: false,
      errors: current_user.errors.full_messages
    }, status: :unprocessable_entity
  end
end

  private

  def profile_params
    params.permit(
      :first_name,
      :last_name,
      :email,
      :phone_number,
      :country_code,
      :alternative_number,
      :aadhaar_number,
      :pan_card,
      :date_of_birth,
      :gender,
      :business_name,
      :business_owner_type,
      :business_nature_type,
      :business_registration_number,
      :gst_number,
      :pan_number,
      :address,
      :city,
      :state,
      :pincode,
      :landmark,
      :username,
      :bank_name,
      :account_number,
      :ifsc_code,
      :account_holder_name,
      :company_type,
      :company_name,
      :cin_number,
      :domain_name,
      :permanent_address,
      :permanent_landmark,
      :permanent_city,
      :permanent_state,
      :permanent_pincode,
      :permanent_postal_code,
      :latitude,
      :longitude,
      :location,
      :image,
      :pan_card_image,
      :aadhaar_image,
      :aadhaar_front_image,
      :aadhaar_back_image,
      :passport_photo,
      :store_shop_photo,
      :address_proof_photo
    )
  end
end