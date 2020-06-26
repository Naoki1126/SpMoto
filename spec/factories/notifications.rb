FactoryBot.define do
  factory :notification, class:Notification do
     visitor_id { Faker::Lorem.characters(number:10) }
     visited_id { Faker::Lorem.characters(number:10) }
     action {''}
     checked {false}
  end
end