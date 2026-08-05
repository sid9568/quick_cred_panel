class Commission < ApplicationRecord
  belongs_to :service_product_item
  belongs_to :scheme, optional: true

  ROLE_ORDER = ["superadmin", "admin", "master", "dealer", "retailer"]

  # NEW UPDATED METHOD
  def self.chain_for(service_id)
    # STEP 1: fetch all items belonging to this service
    item_ids = ServiceProductItem
    .joins(service_product: { category: :service })
    .where(services: { id: service_id })
    .pluck(:id)

    # STEP 2: find commissions of these items
    rows = Commission.where(service_product_item_id: item_ids)

    # STEP 3: build chain for roles
    chain = rows.each_with_object({}) do |r, h|
      h[r.set_for_role] = r.value.to_f
    end

    values = {}
    ROLE_ORDER.each do |role|
      values[role] = chain[role] if chain.key?(role)
    end

    # STEP 4: margins calculate
    margins = {}
    ROLE_ORDER.each_cons(2) do |parent, child|
      if values[parent] && values[child]
        margins[parent] = (values[parent] - values[child]).round(2)
      end
    end

    { values: values, margins: margins }
  end

end
