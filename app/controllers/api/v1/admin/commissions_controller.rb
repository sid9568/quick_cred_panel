class Api::V1::Admin::CommissionsController < Api::V1::Auth::BaseController

  def index
    service_id = params[:id]

    # ❌ Service ID required
    if service_id.blank?
      return render json: {
        code: 400,
        message: "service_id is required",
        data: []
      }
    end

    # Fetch service products with items
    service_products = ServiceProduct
    .includes(:service_product_items, category: :service)
    .joins(category: :service)
    .where(services: { id: service_id })

    render json: {
      code: 200,
      message: "Service product list fetched successfully",
      data: format_products(service_products)
    }
  end

  ROLE_ORDER = ["superadmin", "admin", "master", "dealer", "retailer"]

  PARENT_ROLES = {
    "admin"     => "superadmin",
    "master"    => "admin",
    "dealer"    => "master",
    "retailer"  => "dealer"
  }

  # POST /api/v1/admin/commissions/save_commission
  def save_commission
    # ---------------------------
    # 1️⃣ Validate presence
    # ---------------------------

    if params[:value].blank?
      return render json: { code: 422, message: "Value is required" }
    end

    if params[:set_for_role].blank?
      return render json: { code: 422, message: "set_for_role is required" }
    end

    # ---------------------------
    # 2️⃣ Parent Commission Check
    # ---------------------------
    parent_role = PARENT_ROLES[params[:set_for_role]]

    if parent_role.present?
      parent = Commission.find_by(
        service_product_item_id: @item.id,
        set_for_role: parent_role
      )

      if parent.present? && params[:value].to_f > parent.value.to_f
        return render json: {
          code: 422,
          message: "Cannot set commission higher than parent role (#{parent.value}%)"
        }
      end
    end


    commission = Commission.find_or_initialize_by(
      service_product_item_id: @item.id,
      set_for_role: params[:set_for_role],
      set_by_role: current_user.role.title
    )

    commission.value           = params[:value]
    commission.commission_type = params[:commission_type] || "percent"
    commission.scheme_id       = params[:scheme_id]

    commission.save!

    render json: {
      code: 200,
      message: "Commission saved successfully",
      data: commission
    }
  end

  def show_commission
    @service_id = params[:id]

    if @service_id.blank?
      flash[:alert] = "Service ID is required"
      return redirect_to superadmin_recharge_and_bill_index_path
    end

    @commissions = Commission.chain_for(@service_id)
    p "==========commission"
    p @commissions
  end

  def commission_set
    if params[:scheme].blank?
      return render json: {
        success: false,
        message: "Please select a scheme before submitting commissions."
      }, status: :bad_request
    end

    commission_type = params[:commission_type]
    scheme = Scheme.find(params[:scheme])

    Rails.logger.info "Commission set started for scheme ID #{scheme.id}"

    error_messages = []
    success_count = 0

    params[:commissions].each do |item_id, commission_params|
      item = ServiceProductItem.find(item_id)

      filtered_commissions = commission_params.reject { |_k, v| v.blank? || v == "%" }

      if filtered_commissions.empty?
        Rails.logger.info "Skipping #{item.name}, no valid commission entered"
        next
      end

      total_commission = filtered_commissions.values.map(&:to_f).sum

      if total_commission <= scheme.commision_rate.to_f
        begin
          filtered_commissions.each do |role_key, value|
            role_name = role_key.gsub("_commission", "")

            save_commission(item, scheme, commission_type, "superadmin", role_name, value.to_f)
            Rails.logger.info "Commission saved for #{item.name} => #{role_name} : #{value}"
          end

          success_count += 1

        rescue => e
          error_messages << "For item #{item.name}, error: #{e.message}"
          Rails.logger.error "Commission save error for item #{item.name}: #{e.message}"
        end
      else
        error_messages << "For item #{item.name}, total commission (#{total_commission}) exceeds scheme limit (#{scheme.commision_rate})."
        Rails.logger.warn "Commission total exceeded for item #{item.name}: #{total_commission}, limit #{scheme.commision_rate}"
      end
    end

    if error_messages.any?
      render json: {
        success: false,
        errors: error_messages
      }, status: :unprocessable_entity
    else
      render json: {
        success: true,
        message: "#{success_count} item(s) commissions saved successfully!"
      }, status: :ok
    end
  end


  private

  def format_products(products)
    products.map do |sp|
      {
        id: sp.id,
        name: sp.company_name,
        company_name: sp.company_name,
        service_product_items: sp.service_product_items.map do |item|
          {
            id: item.id,
            name: item.name
          }
        end
      }
    end
  end


  def save_commission(item, scheme, commission_type, from_role, to_role, value)
    return if value.blank?

    commission = Commission.find_or_initialize_by(
      service_product_item: item,
      commission_type: commission_type,
      from_role: from_role,
      to_role: to_role,
      scheme_id: scheme.id
    )
    commission.value = value
    commission.save!
  end

end
