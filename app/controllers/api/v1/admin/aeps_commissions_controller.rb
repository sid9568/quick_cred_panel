class Api::V1::Admin::AepsCommissionsController < Api::V1::Auth::BaseController
  before_action :set_commission, only: [:update, :destroy]

  # GET /api/v1/admin/aeps_commissions
  def index
    aeps_commissions = AepsCommissionSlabRange.where(to_role: current_user.role.title).order(created_at: :desc, updated_at: :desc)
    render json: {code: 200, message: "list show successfully", aeps_commissions: aeps_commissions}
  end

  def show_aeps_commission
    scheme_id = params[:scheme_id]
    p "==================scheme_id"
    p scheme_id
    commissions_slabs = AepsCommissionSlab.where(scheme_id: scheme_id).order(created_at: :desc)

    p "================commissions_slabs============="
    p commissions_slabs

    grouped_data = commissions_slabs.group_by(&:dmt_commission_slab_range_id)

    p "===========grouped_data========="
    p grouped_data

    result = grouped_data.map do |range_id, slabs|
      {
        dmt_commission_slab_range_id: range_id,
        slabs: slabs
      }
    end

    render json: {
      code: "200",
      message: "list show_dmt_commission successfully",
      commissions_slabs: result
    }
  end  

  # POST /api/v1/admin/aeps_commissions
  # params: id (=> parent range id), scheme_id, admin_commission, master_commission, dealer_commission, retailer_commission
  # Creates new slab if not present for a role, updates it if already present. Same action handles both.
  def create
    scheme_id    = params[:scheme_id]
    current_role = current_user.role.title
    parent_slab  = AepsCommissionSlabRange.find_by(id: params[:id])

    return render json: {
      code: 422,
      message: "Parent commission slab not found"
    } if parent_slab.nil?

    role_map = {
      "admin"    => params[:admin_commission],
      "master"   => params[:master_commission],
      "dealer"   => params[:dealer_commission],
      "retailer" => params[:retailer_commission]
    }

    created = []
    updated = []

    role_map.each do |role, value|
      next if value.blank?
      value = value.to_f

      # ❌ Parent limit validation
      if value > parent_slab.value.to_f
        return render json: {
          code: 422,
          message: "#{role.capitalize} commission (#{value}%) cannot exceed parent limit (#{parent_slab.value}%)"
        }
      end

      slab = AepsCommissionSlab.find_by(
        to_role: role,
        scheme_id: scheme_id,
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
          active:      true,
          aeps_commission_slab_range_id: parent_slab.id
        )
        created << role
      end
    end

    render json: {
      code: 200,
      message: "AePS commission saved successfully",
      created_for: created,
      updated_for: updated
    }
  rescue => e
    render json: {
      code: 500,
      message: "Something went wrong",
      error: e.message
    }
  end

  # PUT /api/v1/admin/aeps_commissions/:id
  # Direct single-record update (edit one role's slab by its own id)
  def update
    if @commission.update(commission_params)
      render json: { code: 200, message: "Commission updated", data: @commission }
    else
      render json: { code: 422, message: @commission.errors.full_messages.join(", ") }
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