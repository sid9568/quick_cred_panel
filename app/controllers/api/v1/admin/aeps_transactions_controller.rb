class Api::V1::Admin::AepsTransactionsController < Api::V1::Auth::BaseController
  # GET /api/v1/admin/aeps_transactions
  def index
    users = [current_user] + current_user.all_descendants

    aeps_transactions = AepsTransaction
      .where(user_id: users.map(&:id))
      .order(created_at: :desc)

    render json: {
      code: 200,
      message: "List shown successfully",
      aeps_transactions: aeps_transactions
    }
  end
end
