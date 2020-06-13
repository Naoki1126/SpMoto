FactoryBot.define do
  factory :event_comment do
    user_id { FactoryBot.create(:user).id }
    event_id { FactoryBot.create(:event).id }
    comment { 'testテストtesu' }
  end
end
