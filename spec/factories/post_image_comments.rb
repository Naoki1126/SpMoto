FactoryBot.define do
  factory :post_image_comment do
    user_id { FactoryBot.create(:user).id }
    post_image_id { FactoryBot.create(:post_image).id }
    comment { "tesuttテストtest" }
  end
end