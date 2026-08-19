FactoryBot.define do
  factory :scheme do
    sequence(:scheme_name) { |n| "Scheme #{n}" }
    scheme_type { "standard" }
    commision_rate { 1.0 }
    association :user
  end
end
