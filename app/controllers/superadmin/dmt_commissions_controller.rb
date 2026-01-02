class Superadmin::DmtCommissionsController < Superadmin::BaseController

  before_action :set_commission, only: [:edit, :update, :destroy]

  # LIST
  def index
    @commission_slabs = DmtCommissionSlabRange.order(:min_amount)
    p "===================commission_slabs"
    p @commission_slabs.count
    p @commission_slabs
  end

  # NEW FORM
  def new
    @commission_slab = DmtCommissionSlabRange.new
    @schemes = Scheme.where(user_id: current_superadmin.id)
  end

  # CREATE
  def create
    @commission_slab = DmtCommissionSlabRange.new(commission_params.merge(from_role: current_superadmin.role.title, to_role: "admin"))

    ActiveRecord::Base.transaction do
      @commission_slab.save!

      DmtCommissionSlab.create!(
        dmt_commission_slab_range_id: @commission_slab.id,
        min_amount:  @commission_slab.min_amount,
        max_amount:  @commission_slab.max_amount,
        eko_fee:     @commission_slab.eko_fee,
        surcharge:   @commission_slab.surcharge,
        from_role:   current_superadmin.role.title,
        to_role:     "admin",
        scheme_id:   @commission_slab.scheme_id,
        value: @commission_slab.value
      )
    end

    redirect_to superadmin_dmt_commissions_path,
      notice: "Commission slab created successfully"

  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error e.message
    @schemes = Scheme.where(user_id: current_superadmin.id)
    render :new, status: :unprocessable_entity
  end


  # EDIT FORM
  def edit
    @schemes = Scheme.where(user_id: current_superadmin.id)
  end

  # UPDATE
  def update
    if @commission_slab.update(commission_params)
      redirect_to superadmin_dmt_commissions_path,
        notice: "Commission slab updated successfully"
    else
      @schemes = Scheme.where(user_id: current_superadmin.id)
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE
  def destroy
    @commission_slab.destroy
    redirect_to superadmin_dmt_commissions_path,
      notice: "Commission slab deleted successfully"
  end

  private

  def set_commission
    @commission_slab = DmtCommissionSlabRange.find(params[:id])
  end

  def commission_params
    params.require(:dmt_commission_slab_range).permit(
      :scheme_id,
      :min_amount,
      :max_amount,
      :bank_fee_percent,
      :eko_fee,
      :surcharge,
      :tds_percent,
      :gst_percent,
      :from_role,
      :to_role,
      :value,
      :active
    )
  end
end
