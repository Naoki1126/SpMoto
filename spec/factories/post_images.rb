FactoryBot.define do
  factory :post_image do
    body { Faker::Lorem.characters(number:10) }
    hashbody { "#testtestest" }
    user
    after(:build) do |post_image|
    	post_image.post_image_images << FactoryBot.build(:post_image_image)
    end

  end
end
