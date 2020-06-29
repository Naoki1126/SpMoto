FactoryBot.define do
  factory :event do
    user
    title { Faker::Lorem.characters(number:10) }
    body { Faker::Lorem.characters(number:20) }
    prefecture_code { 2 }
    capacity { 5 }
    date_and_time{ "Fri, 29 May 2020 11:11:00 JST +09:00" }
    meetingplace{ "11111" }
    meetingfinishtime{ "Fri, 29 May 2020 11:11:00 JST +09:00" }
    latitude{ -34.397 }
    longitude{ 150.644 }

  end
end
