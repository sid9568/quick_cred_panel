class Api::V1::Agent::CommissionReportsController < Api::V1::Auth::BaseController
  # protect_from_forgery with: :null_session

  def index
    commission_lists = Commission
    .includes(service_product_item: :service_product)
    .where(scheme_id: current_user.scheme_id)

    render json: {
      code: 200,
      message: "Successfully list show",
      commission_lists: commission_lists.map do |commission|
        {
          id: commission.id,
          commission_type: commission.commission_type,
          value: commission.value,
          from_role: commission.from_role,
          to_role: commission.to_role,
          scheme_id: commission.scheme_id,
          created_at: commission.created_at,
          updated_at: commission.updated_at,

          service_product_item: commission.service_product_item && {
            id: commission.service_product_item.id,
            name: commission.service_product_item.name,

            # ✅ FULL service_product JSON
            service_product: commission.service_product_item.service_product&.as_json(
              only: [:id, :company_name]
            )
          }
        }
      end
    }
  end






end
