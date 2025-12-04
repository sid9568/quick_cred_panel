class Superadmin::BaseController < ApplicationController
  before_action :require_superadmin
  before_action :set_wallet_balance

  helper_method :current_superadmin

  private

  def current_superadmin
    @current_superadmin ||= User.find_by(id: session[:superadmin_user_id])
  end

  def require_superadmin
    unless current_superadmin&.role&.title&.downcase == "superadmin"
      redirect_to superadmin_sessions_login_path, alert: "Access denied!"
    end
  end

  def set_wallet_balance
    if current_superadmin
      @balance = Wallet.where(user_id: current_superadmin.id).sum(:balance)
    else
      @balance = 0
    end
  end
end
