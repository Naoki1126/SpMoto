FactoryBot.define do
  factory :post_image_favorite do
    user_id { FactoryBot.create(:user).id }
    post_image_id { FactoryBot.create(:post_image).id }
  end
end
