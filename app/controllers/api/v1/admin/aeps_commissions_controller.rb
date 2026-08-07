class Api::V1::Admin::AepsCommissionsController < Api::V1::Auth::BaseController
  before_action :set_commission, only: [:update, :destroy]

  # GET /api/v1/admin/aeps_commissions
  def index
    service_type = params[:service_type].presence || "transaction"

    aeps_commissions = AepsCommissionSlabRange
      .where(to_role: current_user.role.title, service_type: service_type)
      .order(created_at: :desc, updated_at: :desc)

    render json: { code: 200, message: "list show successfully", aeps_commissions: aeps_commissions }
  end

def show_aeps_commission
  scheme_id = params[:scheme_id]
  service_type = params[:service_type].presence || "transaction"

  commissions_slabs = AepsCommissionSlab
                        .where(
                          scheme_id: scheme_id,
                          service_type: service_type
                        )
                        .order(created_at: :desc)
  
  grouped_data = commissions_slabs.group_by(&:aeps_commission_slab_range_id)

  result = grouped_data.map do |range_id, slabs|
    {
      aeps_commission_slab_range_id: range_id,
      slabs: slabs
    }
  end

  render json: {
    code: "200",
    message: "list show_aeps_commission successfully",
    commissions_slabs: result
  }
end

  # POST /api/v1/admin/aeps_commissions
  # params: id (=> parent range id), scheme_id, admin_commission, master_commission, dealer_commission, retailer_commission
  # Creates new slab if not present for a role, updates it if already present. Same action handles both.
def create
  scheme_id     = params[:scheme_id]
  service_type  = params[:service_type] # "transaction" / "mini_statement" / "fund_settlement"
  current_role  = current_user.role.title

  parent_slab = AepsCommissionSlabRange.find_by(
    id: params[:aeps_commission_slab_range_id],
    service_type: service_type
  )
  return render json: {
    code: 422,
    message: "Parent commission slab not found"
  } if parent_slab.nil?

  role_map =
    if service_type == "fund_settlement" || service_type == "mini_statement"
      { "master" => params[:master_commission], "master" => params[:dealer_commission], "retailer" => params[:retailer_commission] }
    else
      { "master" => params[:master_commission], "dealer" => params[:dealer_commission], "retailer" => params[:retailer_commission] }
    end

  total_commission = role_map.values.compact_blank.sum { |v| v.to_f }
  if total_commission > parent_slab.value.to_f
    return render json: {
      code: 422,
      message: "Total commission (#{total_commission}%) cannot exceed parent limit (#{parent_slab.value}%)"
    }
  end

  created = []
  updated = []
  role_map.each do |role, value|
    next if value.blank?
    next if role.to_s.downcase == current_role.to_s.downcase   # ✅ khud ko commission nahi

    value = value.to_f

    slab = AepsCommissionSlab.find_by(
      to_role: role,
      scheme_id: scheme_id,
      service_type: service_type,
      aeps_commission_slab_range_id: parent_slab.id
    )
    if slab.present?
      slab.update!(value: value)
      updated << role
    else
      AepsCommissionSlab.create!(
        min_amount:  parent_slab.min_amount,
        max_amount:  parent_slab.max_amount,
        tds_percent: parent_slab.tds_percent,
        gst_percent: parent_slab.gst_percent,
        from_role:   current_role,
        to_role:     role,
        value:       value,
        surcharge:   parent_slab.surcharge,
        scheme_id:   scheme_id,
        service_type: service_type,
        active:      true,
        aeps_commission_slab_range_id: parent_slab.id
      )
      created << role
    end
  end

  render json: {
    code: 200,
    message: "#{service_type.humanize} commission saved successfully",
    created_for: created,
    updated_for: updated
  }
rescue => e
  render json: { code: 500, message: "Something went wrong", error: e.message }
end

  # PUT /api/v1/admin/aeps_commissions/:id
  # Direct single-record update (edit one role's slab by its own id)
  def update
    if @commission.update(commission_params)
      render json: { code: 200, message: "Commission updated", data: @commission }
    else
      render json: { code: 420, message: @commission.errors.full_messages.join(", ") }
    end
  end

  # DELETE /api/v1/admin/aeps_commissions/:id
  def destroy
    @commission.destroy
    render json: { code: 200, message: "Commission deleted" }
  end

  private

  def set_commission
    @commission = AepsCommissionSlab.find_by(id: params[:id])
    render json: { code: 404, message: "Commission not found" } unless @commission
  end

  def commission_params
    params.permit(
      :scheme_id, :aeps_commission_slab_range_id,
      :min_amount, :max_amount, :tds_percent, :gst_percent, :surcharge,
      :from_role, :to_role, :value, :active
    )
  end
end