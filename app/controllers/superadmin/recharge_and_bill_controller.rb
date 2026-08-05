class Superadmin::RechargeAndBillController < Superadmin::BaseController


  # def index
  #   # Check dynamically if Commission table has scheme_id column
  #   has_scheme_column = Commission.column_names.include?("scheme_id")

  #   if has_scheme_column
  #     # ✅ Case 1: Commission model has scheme_id — apply filter logic
  #     if params[:scheme].present? && params[:scheme] != "ALL"
  #       @grouped_commissions = Commission
  #       .includes(service_product_item: :service_product)
  #       .where(scheme_id: params[:scheme])
  #       .select('DISTINCT ON (service_product_item_id) commissions.*')
  #       .group_by { |c| c.service_product_item.service_product.company_name }
  #     else
  #       @grouped_commissions = Commission
  #       .includes(service_product_item: :service_product)
  #       .select('DISTINCT ON (service_product_item_id) commissions.*')
  #       .group_by { |c| c.service_product_item.service_product.company_name }
  #     end

  #   else
  #     # ❌ Case 2: Commission has no scheme_id — update Scheme table instead
  #     if params[:scheme].present? && params[:scheme] != "ALL"
  #       selected_scheme = Scheme.find_by(id: params[:scheme])
  #       if selected_scheme
  #         # Example: mark this scheme active or update a flag/column
  #         Scheme.update_all(active: false) # optional line — resets all
  #         selected_scheme.update(active: true)
  #         flash[:notice] = "✅ Scheme updated to #{selected_scheme.scheme_name}"
  #       else
  #         flash[:alert] = "⚠️ Selected scheme not found."
  #       end
  #     end

  #     # Show all commissions by default
  #     @grouped_commissions = Commission
  #     .includes(service_product_item: :service_product)
  #     .select('DISTINCT ON (service_product_item_id) commissions.*')
  #     .group_by { |c| c.service_product_item.service_product.company_name }
  #   end
  # end


  def index
  end

  def bbps_commission
    @existing_commissions = Commission.all.group_by(&:service_product_item_id)
    @schemes = Scheme.where(user_id: current_superadmin.id).order(created_at: :desc)

    @service_id = params[:service_id]
    @product_id = params[:product_id]

    # For product dropdown population
    @service_products =
    if @service_id.present?
      ServiceProduct.where(category_id: @service_id)
    else
      ServiceProduct.all
    end

    # Main products query
    products = ServiceProduct
    .includes(:service_product_items, category: :service)
    .joins(category: :service)

    products = products.where(services: { id: @service_id }) if @service_id.present?
    products = products.where(id: @product_id) if @product_id.present?

    @grouped_commissions = products.group_by { |p| p.category.title }
  end


  def commission_set
    if params[:scheme].blank?
      redirect_to superadmin_recharge_and_bill_bbps_commission_path(id: 7),
        alert: "Please select a scheme before submitting commissions."
      return
    end

    commission_type = params[:commission_type]
    scheme = Scheme.find(params[:scheme])

    Rails.logger.info "Commission set started for scheme ID #{scheme.id}"

    error_messages = []
    success_count = 0

    params[:commissions].each do |item_id, commission_params|
      item = ServiceProductItem.find(item_id)

      # Filter out blank / "%" values
      filtered_commissions = commission_params.reject { |_k, v| v.blank? || v == "%" }

      # If nothing is entered, skip item
      if filtered_commissions.empty?
        Rails.logger.info "Skipping #{item.name}, no valid commission entered"
        next
      end

      total_commission = filtered_commissions.values.map(&:to_f).sum

      # Validate total commission <= scheme rate
      if total_commission <= scheme.commision_rate.to_f
        begin
          filtered_commissions.each do |role_key, value|
            role_name = role_key.gsub("_commission", "")  # "admin_commission" => "admin"

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
        Rails.logger.warn "Commission total exceeded for item #{item.name}: total #{total_commission}, limit #{scheme.commision_rate}"
      end
    end

    if error_messages.any?
      redirect_to superadmin_recharge_and_bill_bbps_commission_path(id: 7), alert: error_messages.join(", ")
    else
      redirect_to superadmin_recharge_and_bill_bbps_commission_path(id: 7),
        notice: "#{success_count} item(s) commissions saved successfully!"
    end
  end



  def view
    @transcation = Transaction.find(params[:id]).order(created_at: :desc)
  end

  def transaction

    @transcations = Transaction.all.order(created_at: :desc)

    # Filter by type (join only if needed)
    if params[:type].present? && params[:type] != "all"
      @transcations = @transcations.eager_load(:service_product).where(service_products: { company_name: params[:type] })
    end

    # Filter by search keyword
    if params[:search].present?
      search_term = "%#{params[:search]}%"
      @transcations = @transcations.where(
        "tx_id ILIKE :search OR account_or_mobile ILIKE :search OR operator ILIKE :search",
        search: search_term
      )
    end

    # Eager load service_product to avoid N+1 in view
    @transcations = @transcations.includes(:service_product)

    logger.info "------------ Tr -------------"
    logger.info @transcations.to_sql # better than inspecting all records
  end


  private

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
    Rails.logger.info "Saved commission for item #{item.name}, from #{from_role} to #{to_role}, value #{value}"
  end


end
