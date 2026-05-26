class Api::V1::Agent::LeaveRequestsController < Api::V1::Auth::BaseController
  before_action :set_leave_request, only: [:show, :update, :destroy]

  def index
    leave_requests = current_user.leave_requests.order(created_at: :desc)

    render json: {
      code: 200,
      leave_requests: leave_requests
    }
  end

  def show
    render json: {
      code: 200,
      leave_request: @leave_request
    }
  end

  def create
    leave_request = current_user.leave_requests.new(leave_request_params)

    leave_request.parent_id = current_user.parent_id

    leave_request.total_days =
      (leave_request.end_date - leave_request.start_date).to_i + 1

    if leave_request.save
      render json: {
        code: 201,
        message: "Leave request created successfully",
        leave_request: leave_request
      }
    else
      render json: {
        code: 422,
        errors: leave_request.errors.full_messages
      }
    end
  end

  def update
    if @leave_request.update(leave_request_params)

      if @leave_request.start_date.present? && @leave_request.end_date.present?
        @leave_request.update(
          total_days: (@leave_request.end_date - @leave_request.start_date).to_i + 1
        )
      end

      render json: {
        code: 200,
        message: "Leave request updated successfully",
        leave_request: @leave_request
      }
    else
      render json: {
        code: 422,
        errors: @leave_request.errors.full_messages
      }
    end
  end

  def destroy
    @leave_request.destroy

    render json: {
      code: 200,
      message: "Leave request deleted successfully"
    }
  end

  private

  def set_leave_request
    @leave_request = current_user.leave_requests.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {
      code: 404,
      message: "Leave request not found"
    }
  end

  def leave_request_params
    params.require(:leave_request).permit(
      :start_date,
      :end_date,
      :reason,
      :status,
      :approve_note,
      :reject_note
    )
  end
end