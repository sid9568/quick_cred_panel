FactoryBot.define do
  factory :aeps_wallet do
    association :user
    balance { 0 }
  end
end
