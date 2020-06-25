require 'rails_helper'

RSpec.describe "EventParticipates", type: :request do
	require 'rails_helper'

RSpec.describe "Events", type: :request do
	describe 'httpレスポンスのテスト' do

		before do
			@user = FactoryBot.create(:user)
			@event = FactoryBot.create(:event)
			@participate = EventParticipates.where(event_id: @event.id)
		end

		context 'events#index' do
			login_as @user
			it 'events/indexにアクセス出来ること' do
				get  event_event_paricipates_path
				expect(response).to have_http_status(:success)
			end
		end
	end
end
end
