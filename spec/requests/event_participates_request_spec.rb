require 'rails_helper'

RSpec.describe "EventParticipates", type: :request do
	describe 'httpレスポンスのテスト' do

		before do
			@user = FactoryBot.create(:user)
			@event = FactoryBot.create(:event)
			@participate = FactoryBot.create(:event_participate)
			@participate.event_id = @event
		end


		context 'ログインなしでアクセス出来ないこと' do
			it 'event_participate/create'do
				post event_event_participates_path(event_id: @event.id)
				expect(response).to have_http_status 302
			end

			it 'even_participate/destroy' do
				delete event_event_participates_path(event_id: @event.id)
				expect(response).to have_http_status 302
			end


			it 'event_participate/index' do
				get  event_event_paricipates_path(event_id: @event.id)
				expect(response).to have_http_status 302
			end			
		end
	end
end
