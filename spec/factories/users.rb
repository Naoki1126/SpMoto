FactoryBot.define do
  factory :user, class:User do
    name { Faker::Lorem.characters(number:10) }
  	sequence(:email) { |n| "other#{n}@example.com" }
    introduction { Faker::Lorem.characters(number:10) }
    password { '111111'}
    password_confirmation { '111111' }
    prefecture_code { '2' }
  end
end
