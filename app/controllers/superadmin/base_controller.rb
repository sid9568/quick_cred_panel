class Superadmin::BaseController < ApplicationController
  before_action :require_superadmin
  before_action :set_wallet_balance
  before_action :api_balance   # 👈 add this

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

  # 🔹 Local DB wallet balance (already present)
  def set_wallet_balance
    if current_superadmin
      @balance = Wallet.where(user_id: current_superadmin.id).sum(:balance)
    else
      @balance = 0
    end
  end

  # 🔹 EKO API wallet balance
  def api_balance
    return unless current_superadmin

    begin
      service = Eko::WalletService.new

      response = service.get_wallet_balance(
        "mobile",
        "9212094999",   # 👈 customer_id
        "38130001" # 👈 user_code
      )

      if response["status"] == 0
        @api_wallet_balance = response.dig("data", "balance")
        p "=========@api_wallet_balance============="
        p @api_wallet_balance
        @api_wallet_currency = response.dig("data", "currency")
      else
        Rails.logger.error "EKO API Error: #{response}"
        @api_wallet_balance = 0
      end

    rescue => e
      Rails.logger.error "EKO API Exception: #{e.message}"
      @api_wallet_balance = 0
    end
  end
end
