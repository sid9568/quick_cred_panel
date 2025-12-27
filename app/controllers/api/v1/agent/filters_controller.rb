class Api::V1::Agent::FiltersController <  Api::V1::Auth::BaseController
  # protect_from_forgery with: :null_session

  def category_filter
    service_id = params[:service_id]
    categories = Category.where(service_id: service_id)
    render json: {code: 200, message: "fetch data", categories: categories}
  end

  def service_product
    category_id = params[:category_id]
    if category_id.present?
      service_products = ServiceProduct.where(category_id: category_id)
      render json: { code: 200, message: "fetch data", service_products: service_products }
    else
      render json: { code: 401, message: "category is is missing", service_products: service_products }
    end
  end

  def service_category_filter
    transactions = Transaction
    .where(user_id: current_user.id)
    .includes(
      :transaction_commissions,
      :user,
      service_product: :category
    )
    .order(created_at: :desc)

    # 🔹 Filter by service_product_id
    if params[:service_product_id].present? && params[:service_product_id] != "ALL"
      transactions = transactions.where(service_product_id: params[:service_product_id])
    end

    # 🔹 Filter by status
    if params[:status].present? && params[:status] != "ALL"
      transactions = transactions.where(status: params[:status])
    end

    # 🔹 Filter by date range
    if params[:from_date].present? && params[:to_date].present?
      begin
        date_range =
          Date.parse(params[:from_date]).beginning_of_day..
          Date.parse(params[:to_date]).end_of_day

        transactions = transactions.where(created_at: date_range)
      rescue ArgumentError
        Rails.logger.warn(
          "Invalid date range: #{params[:from_date]} - #{params[:to_date]}"
        )
      end
    end

    filter = transactions.map do |t|
      t.as_json(
        only: [
          :id, :tx_id, :operator, :transaction_type,
          :account_or_mobile, :amount, :status,
          :user_id, :created_at, :consumer_name, :mobile
        ]
      ).merge(
        consumer_no_Name: t.user&.first_name,
        role: current_user.role&.title,
        service_type: t.service_product&.category&.title,
        sub_service: t.service_product&.company_name,

        # ✅ ONLY current_user commission
        transaction_commissions: t.transaction_commissions
        .select { |tc| tc.user_id == current_user.id }
      )
    end

    render json: {
      code: 200,
      message: "fetch data",
      filter: filter
    }
  end




end
