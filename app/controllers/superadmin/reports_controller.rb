class Superadmin::ReportsController < Superadmin::BaseController

  def index
    @services = Service.all.order(:position)
    @commissions = Commission.all.includes(:scheme, :service_product_item).order(created_at: :desc)
  end

  def report_filter
    @category_id = params[:id]
    # ---------- SERVICE → CATEGORY ----------
    if params[:id].present? && params[:id] != "ALL"
      @categories = Category.where(service_id: params[:id])
    else
      @categories = Category.none
    end

    # ---------- CATEGORY → SERVICE PRODUCT ----------
    # IMPORTANT: Jab category select nahi ki gayi hai to service products empty hone chahiye
    if params[:category_id].present? && params[:category_id] != "ALL"
      @service_products = ServiceProduct.where(category_id: params[:category_id])
    else
      @service_products = ServiceProduct.none
    end

    # ---------- BASE TRANSACTION QUERY ----------
    @transactions = Transaction
    .includes(:user, service_product: :category)
    .order(created_at: :desc)

    # ---------- TRANSACTION FILTER (SERVICE PRODUCT) ----------
    # IMPORTANT: Agar service_product_id "ALL" hai ya empty hai, to filter nahi lagana
    if params[:service_product_id].present? && params[:service_product_id] != "ALL"
      @transactions = @transactions.where(service_product_id: params[:service_product_id])
    end

    # ---------- CATEGORY FILTER (DIRECT) ----------
    # Agar directly category_id filter apply karna hai
    if params[:category_id].present? && params[:category_id] != "ALL"
      @transactions = @transactions.joins(service_product: :category)
      .where(categories: { id: params[:category_id] })
    end

    # ---------- STATUS FILTER ----------
    if params[:status].present? && params[:status] != "ALL"
      @transactions = @transactions.where(status: params[:status])
    end

    # ---------- DATE FILTER ----------
    if params[:from_date].present? && params[:to_date].present?
      begin
        start_date = Date.parse(params[:from_date]).beginning_of_day
        end_date   = Date.parse(params[:to_date]).end_of_day
        @transactions = @transactions.where(created_at: start_date..end_date)
      rescue ArgumentError
        Rails.logger.warn "Invalid date format"
      end
    end
  end


end
