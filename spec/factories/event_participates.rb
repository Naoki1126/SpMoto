FactoryBot.define do
  factory :event_participate do
    user_id { FactoryBot.create(:user).id }
    event_id { FactoryBot.create(:event).id }
  end
end
