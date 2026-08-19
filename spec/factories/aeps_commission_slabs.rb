FactoryBot.define do
  factory :aeps_commission_slab do
    service_type { "transaction" }
    to_role { "retailer" }
    value { 1.0 } # percent
    active { true }
  end
end
