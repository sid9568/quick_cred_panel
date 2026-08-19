FactoryBot.define do
  factory :user do
    sequence(:first_name) { |n| "User#{n}" }
    last_name { "Test" }
    sequence(:email) { |n| "user#{n}@example.com" }
    sequence(:phone_number) { |n| "9#{100000000 + n}" }
    sequence(:user_code) { |n| "UC#{n}" }
    aeps_latlong { "28.6139,77.2090" }
    status { true }
    association :role, factory: [:role, :retailer]
  end
end
