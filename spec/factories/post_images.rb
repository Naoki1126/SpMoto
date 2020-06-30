FactoryBot.define do
  factory :post_image do 
    body { Faker::Lorem.characters(number:10) }
    hashbody { "#testtestest" }
    user
    
    
  end
end
