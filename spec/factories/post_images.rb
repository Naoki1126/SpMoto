FactoryBot.define do
  factory :post_image do
    user_id { FactoryBot.create(:user).id }
    body { Faker::Lorem.characters(number:10) }
    hashbody { "#testtestest" }
  end
end
