class Api::V1::Admin::SalariesController < Api::V1::Auth::BaseController
  before_action :set_salary, only: [:show, :update, :destroy]

  def index
    salaries = Salary.order(created_at: :desc)

    render json: {
      success: true,
      message: "Salaries fetched successfully",
      data: salaries
    }, status: :ok
  end

  def show
    render json: {
      success: true,
      message: "Salary fetched successfully",
      data: @salary
    }, status: :ok
  end

  def create
    salary = Salary.new(salary_params)

    if salary.save
      render json: {
        success: true,
        message: "Salary created successfully",
        data: salary
      }, status: :created
    else
      render json: {
        success: false,
        errors: salary.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def update
    if @salary.update(salary_params)
      render json: {
        success: true,
        message: "Salary updated successfully",
        data: @salary
      }, status: :ok
    else
      render json: {
        success: false,
        errors: @salary.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def destroy
    @salary.destroy

    render json: {
      success: true,
      message: "Salary deleted successfully"
    }, status: :ok
  end

  private

  def set_salary
    @salary = Salary.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {
      success: false,
      message: "Salary not found"
    }, status: :not_found
  end

  def salary_params
    params.permit(
      :user_id,
      :month,
      :year,
      :total_days,
      :leave_days,
      :working_days,
      :per_day_salary,
      :total_salary
    )
  end
end