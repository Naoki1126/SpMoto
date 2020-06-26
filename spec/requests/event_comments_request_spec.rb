require 'rails_helper'

RSpec.describe "EventComments", type: :request do
	describe 'httpレスポンスのテスト' do

		before do
			@user = FactoryBot.create(:user)
			@event = FactoryBot.create(:event)
			@comment = FactoryBot.create(:event_comment)
			@comment.event_id = @event
		end


		context 'ログインなしでアクセス出来ないこと' do
			it 'event_participate/create'do
				post event_event_comments_path(event_id: @event.id)
				expect(response).to have_http_status 302
			end

			it 'even_participate/destroy' do
				delete  event_event_comments_path(event_id: @event.id)
				expect(response).to have_http_status 302
			end
		end
	end
end
