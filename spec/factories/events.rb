FactoryBot.define do
  factory :event do
    user
    title { Faker::Lorem.characters(number:10) }
    body { Faker::Lorem.characters(number:20) }
    prefecture_code { 2 }
    capacity { 5 }
    date_and_time{ Time.now }
    meetingplace{ "11111" }
    meetingfinishtime{ Time.now }
    latitude{ -34.397 }
    longitude{ 150.644 }

  end
end
