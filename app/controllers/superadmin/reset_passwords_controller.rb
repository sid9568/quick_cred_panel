class Superadmin::ResetPasswordsController < Superadmin::BaseController
  # before_action :require_superadmin_login
  # before_action :authenticate_user!


  def index
  end

  def reset_page

  end

  def reset_password
    @user = current_superadmin
    p "==================user"
    p @user
    p "===========old password #{params[:old_password]} and password #{params[:password].inspect}"

    if @user.authenticate(params[:old_password])
      new_pass = params[:password].is_a?(Array) ? params[:password].first : params[:password]
      p "===============new_pass: #{new_pass.inspect}"

      if @user.update(password: new_pass)
        flash[:notice] = "Password updated successfully!"
        session[:superadmin_user_id] = nil
        redirect_to superadmin_sessions_login_path
      else
        p "Update failed: #{@user.errors.full_messages}"
        flash[:alert] = "Failed to update password"
        render :reset_password
      end
    else
      flash[:alert] = "Old password does not match"
      p "=============Old password mismatch"
      render :reset_password
    end
  end

  def forget_password
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
