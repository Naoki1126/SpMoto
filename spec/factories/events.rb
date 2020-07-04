FactoryBot.define do
  factory :event, class:Event do
    user
    title { Faker::Lorem.characters(number:10) }
    body { Faker::Lorem.characters(number:20) }
    prefecture_code { 2 }
    capacity { 5 }
    date_and_time{ DateTime.now }
    meetingplace{ "11111" }
    meetingfinishtime{ DateTime.tomorrow }
    latitude{ -34.397 }
    longitude{ 150.644 }

  end

  factory :test_event2, class:Event do
    user { FactoryBot.create(:test_user2)}
    title { 'ツーリング' }
    body { Faker::Lorem.characters(number:20) }
    prefecture_code { 2 }
    capacity { 5 }
    date_and_time{ DateTime.now }
    meetingplace{ "11111" }
    meetingfinishtime{ DateTime.tomorrow }
    latitude{ -34.397 }
    longitude{ 150.644 }

  end
end
