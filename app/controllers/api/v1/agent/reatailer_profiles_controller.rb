# app/controllers/api/v1/agent/reatailer_profiles_controller.rb
module Api
  module V1
    module Agent
      class ReatailerProfilesController < Api::V1::Auth::BaseController
        # protect_from_forgery with: :null_session
        skip_before_action :authorize_request

        def index
          render json: { code: 200,message: "Users fetched successfully",users: current_user }, status: :ok
        end

        def set_pin
          if params[:set_pin].present? && params[:confirm_pin].present?
            if params[:set_pin] == params[:confirm_pin]
              current_user.update!(set_pin: params[:set_pin], confirm_pin: params[:confirm_pin])
              render json: { code: 200, message: "Successfully set pin" }
            else
              render json: { code: 422, message: "Pin and confirm pin do not match" }
            end
          else
            render json: { code: 400, message: "Pin and confirm pin are required" }
          end
        end


        def reset_password
          if params[:email].blank?
            return render json: { code: 400, message: "Email is required" }
          end

          user = User.find_by(email: params[:email])

          unless user
            return render json: { code: 404, message: "User not found with this email" }
          end

          otp = rand(100000..999999).to_s

          user.update(
            email_otp: otp,
            email_otp_sent_at: Time.current + 10.minutes
          )

          # ✅ Call mailer correctly
          UserMailer.with(user: user, otp: otp).reset_password_otp.deliver_now

          render json: { code: 200, message: "OTP sent successfully to your email" }

        rescue => e
          render json: { code: 500, message: "Something went wrong while sending OTP", error: e.message }
        end

        def forgot_password
          if params[:email].blank?
            return render json: { code: 400, message: "Email is required" }
          end

          user = User.find_by(email: params[:email])

          unless user
            return render json: { code: 404, message: "User not found with this email" }
          end

          otp = rand(100000..999999).to_s

          user.update(
            email_otp: otp,
            email_otp_sent_at: Time.current + 10.minutes
          )

          # ✅ Call mailer correctly
          UserMailer.with(user: user, otp: otp).reset_password_otp.deliver_now

          render json: { code: 200, message: "OTP sent successfully to your email" }

        rescue => e
          render json: { code: 500, message: "Something went wrong while sending OTP", error: e.message }
        end

        def verify_password_otp
          if params[:email].blank? || params[:otp].blank?
            return render json: { code: 400, message: "Email and OTP are required" }
          end

          user = User.find_by(email: params[:email])

          unless user
            return render json: { code: 404, message: "User not found" }
          end

          # Check OTP correctness
          if user.email_otp != params[:otp]
            return render json: { code: 401, message: "Invalid OTP" }
          end

          # Check OTP Expiry
          if user.email_otp_sent_at.nil? || user.email_otp_sent_at < Time.current
            return render json: { code: 410, message: "OTP has expired, please request again" }
          end

          # OTP Verified → Clear OTP
          user.update(email_otp: nil, email_otp_sent_at: nil)

          render json: { code: 200, message: "OTP verified successfully" }

        rescue => e
          render json: { code: 500, message: "Something went wrong", error: e.message }
        end

        def forget_password
          p "==========="
          unless params[:password].present? && params[:confirm_password].present?
            return render json: { code: 400, message: "New password and confirm password are required" }
          end

          if params[:password] != params[:confirm_password]
            return render json: { code: 400, message: "Password and confirm password do not match" }
          end

          # ✅ Example: update password (assuming you have @user set before)
          if current_user.update(password: params[:password])
            render json: { code: 200, message: "Password updated successfully" }
          else
            render json: { code: 422, message: "Unable to update password", errors: @user.errors.full_messages }
          end
        end

        def main_forget_password
          # Validate email presence
          unless params[:email].present?
            return render json: { code: 400, message: "Email is required" }
          end

          @user = User.find_by(email: params[:email])

          # If user not found
          unless @user
            return render json: { code: 404, message: "User not found with this email" }
          end

          # Validate password inputs
          unless params[:password].present? && params[:confirm_password].present?
            return render json: { code: 400, message: "New password and confirm password are required" }
          end

          if params[:password] != params[:confirm_password]
            return render json: { code: 400, message: "Password and confirm password do not match" }
          end

          # Update the user's password
          if @user.update(password: params[:password])
            render json: { code: 200, message: "Password updated successfully" }
          else
            render json: { code: 422, message: "Unable to update password", errors: @user.errors.full_messages }
          end
        end

      end
    end
  end
end
