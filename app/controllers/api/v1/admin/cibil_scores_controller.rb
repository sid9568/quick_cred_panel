class Api::V1::Admin::CibilScoresController < Api::V1::Auth::BaseController

  def index
    reports = CibilReport
                .where(user_id: current_user.id)
                .order(created_at: :desc)

    render json: {
      success: true,
      total_records: reports.count,
      data: reports.as_json(
        only: [
          :id,
          :bureau,
          :pan,
          :mobile_number,
          :name,
          :credit_score,
          :doc_id,
          :status_code,
          :success,
          :created_at
        ]
      )
    }, status: :ok
  end

  def show
    report = CibilReport.find(params[:id])

    render json: {
      success: true,
      data: report
    }, status: :ok
  end

  def create
    response = Finpass::CibilScoreService.new(
      pan: params[:pan],
      name: params[:name],
      mobile_number: params[:mobile_number],
      consent: params[:consent] || "Y",
      gender: params[:gender],
      bureaus: params[:bureaus] || %w[experian equifax cibil crif]
    ).call

    response_body = response.parsed_response

    save_reports(response_body)

    render json: response_body, status: :ok
  end

  private

  def save_reports(response_body)
    results = response_body["results"] || {}

    results.each do |bureau_name, bureau_data|
      next unless bureau_data["success"]

      CibilReport.create!(
        user_id: current_user.id,
        bureau: bureau_name,
        pan: response_body["pan"] || params[:pan],
        mobile_number: params[:mobile_number],
        name: params[:name],
        credit_score: bureau_data.dig("data", "credit_score"),
        doc_id: response_body["doc_id"],
        status_code: response_body["status_code"],
        success: bureau_data["success"],
        response_data: bureau_data
      )
    end
  end
end