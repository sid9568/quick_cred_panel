class Api::V1::Agent::AepsCommissionsController < Api::V1::Auth::BaseController

  # GET /api/v1/admin/aeps_commissions
  def index
    p "===========current_user"
    p current_user
    aeps_commissions = AepsCommissionSlab.where(scheme_id: current_user.scheme_id, to_role: current_user.role.title).order(created_at: :desc, updated_at: :desc)
    render json: {code: 200, message: "list show successfully", aeps_commissions: aeps_commissions}
  end

end