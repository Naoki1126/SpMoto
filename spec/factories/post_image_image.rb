FactoryBot.define do
  factory :post_image_image do
    post_image_id { FactoryBot.create(:post_image).id }
    image_id { Faker::Lorem.characters(number:10) }
  end

  
end