FactoryBot.define do
  factory :user, class:User do
    name { Faker::Lorem.characters(number:10) }
  	sequence(:email) { |n| "other#{n}@example.com" }
    introduction { Faker::Lorem.characters(number:10) }
    password { '111111'}
    password_confirmation { '111111' }
    prefecture_code { '2' }
  end

  factory :test_user2, class:User do
  	 name { Faker::Lorem.characters(number:10) }
  	sequence(:email) { |n| "tetetetst@example.com" }
    introduction { Faker::Lorem.characters(number:10) }
    password { '111111'}
    password_confirmation { '111111' }
    prefecture_code { '2' }
  end

   factory :test_user3, class:User do
  	name { '丸山' }
  	sequence(:email) { |n| "tttttest@example.com" }
    introduction { Faker::Lorem.characters(number:10) }
    password { '111111'}
    password_confirmation { '111111' }
    prefecture_code { '2' }
  end

  factory :test_user4, class:User do
  	name { '佐藤' }
  	sequence(:email) { |n| "testest@example.com" }
    introduction { Faker::Lorem.characters(number:10) }
    password { '111111'}
    password_confirmation { '111111' }
    prefecture_code { '2' }
  end
end
