class Api::V1::Auth::BaseController < ActionController::API
  before_action :authorize_request
  before_action :api_balance

  def authorize_request
    token = request.headers["Authorization"]&.split(" ")&.last
    return render json: { code: 401, message: "Token missing" } unless token

    begin
      decoded = JsonWebToken.decode(token)
      @current_user = User.find(decoded[:user_id])
    rescue
      return render json: { code: 401, message: "Invalid or expired token" }
    end
  end

  def current_user
    @current_user
  end

  def api_balance
    return unless @current_user

    begin
      service = Eko::WalletService.new
      response = service.get_wallet_balance(
        "mobile",
        "9212094999",
        "38130001"
      )

      if response["status"] == 0
        @api_wallet_balance  = response.dig("data", "balance")
        @api_wallet_currency = response.dig("data", "currency")
      else
        @api_wallet_balance = 0
      end
    rescue => e
      Rails.logger.error e.message
      @api_wallet_balance = 0
    end
  end
end
