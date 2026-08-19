FactoryBot.define do
  factory :aeps_commission_slab_range do
    association :scheme
    service_type { "transaction" }
    min_amount { 0 }
    max_amount { 100_000 }
    value { 2.0 } # admin pool percent
    active { true }
  end
end
