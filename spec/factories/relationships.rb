FactoryBot.define do
  factory :relationship do
  	follow_id { Faker::Lorem.characters(number:10) }
  	user_id { Faker::Lorem.characters(number:10) }
  end
end