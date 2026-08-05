class Api::V1::Admin::LeaveRequestsController < Api::V1::Auth::BaseController

  def index

    leave_requests = LeaveRequest
                      .includes(:user)
                      .where(parent_id: current_user.id)
                      .order(created_at: :desc)

    if leave_requests.any?
      render json: {
        code: 200,
        message: "Child leave requests fetched successfully",
        leave_requests: leave_requests
      }
    else
      render json: {
        code: 404,
        message: "No leave requests found",
        leave_requests: []
      }
    end
  end

end