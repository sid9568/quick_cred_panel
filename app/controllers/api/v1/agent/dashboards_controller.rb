class Api::V1::Agent::DashboardsController < Api::V1::Auth::BaseController
  protect_from_forgery with: :null_session
  def index
  end
end
