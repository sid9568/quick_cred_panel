FactoryBot.define do
  factory :role do
    sequence(:title) { |n| "role_#{n}" }

    trait :retailer do
      title { "retailer" }
    end

    trait :dealer do
      title { "dealer" }
    end

    trait :master do
      title { "master" }
    end

    trait :admin do
      title { "admin" }
    end

    trait :superadmin do
      title { "superadmin" }
    end
  end
end
