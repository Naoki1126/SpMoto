require 'rails_helper'

RSpec.describe "Events", type: :request do
	describe 'httpレスポンスのテスト' do
		let!(:user) { create(:user) }

		before do
			@event = FactoryBot.create(:event)
		end
		context 'ログインなしでアクセス出来ないこと' do
			it ' events/new' do
				get new_event_path
				expect(response).to have_http_status 302
			end

			it 'events/edit' do
				get edit_event_path(1)
				expect(response).to have_http_status 302
			end

			it 'events/show' do
				get event_path(1)
				expect(response).to have_http_status 302
			end

			it 'events/create' do
				post events_path
				expect(response).to have_http_status 302
			end

			it 'event/update' do
				patch event_path(1)
				expect(response).to have_http_status 302
			end
		end

		context 'ログインなしでアクセスできること' do
			it 'events/index' do
				get events_path
				expect(response).to have_http_status 200
			end
		end

	end
end
