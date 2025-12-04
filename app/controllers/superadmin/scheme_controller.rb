class Superadmin::SchemeController < Superadmin::BaseController
  # before_action :authenticate_user!

  before_action :set_scheme, only: [:show, :edit, :update, :destroy]

  def index
    @schemes = Scheme.where(user_id: current_superadmin.id).order(created_at: :desc)
  end

  def show
  end

  def new
    @scheme = Scheme.new
  end

  # POST /admin/schemes
  def create
    @scheme = Scheme.new(scheme_params.merge(user_id: current_superadmin.id))
    if @scheme.save
      redirect_to superadmin_scheme_index_path, notice: "Scheme created successfully."
    else
      redirect_to superadmin_scheme_index_path, notice: "Scheme created Not successfully."
    end
  end

  # GET /admin/schemes/:id/edit
  def edit
  end

  # PATCH/PUT /admin/schemes/:id
  def update
    if @scheme.update(params.permit(:scheme_name, :scheme_type, :commision_rate))
      redirect_to superadmin_scheme_index_path, notice: "Scheme updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/schemes/:id
  def destroy
    @scheme.destroy
    redirect_to superadmin_scheme_index_path, notice: "Scheme deleted successfully."
  end

  private

  def set_scheme
    @scheme = Scheme.find(params[:id])
  end

  def scheme_params
    params.permit(:scheme_name, :scheme_type, :commision_rate)
  end
end
