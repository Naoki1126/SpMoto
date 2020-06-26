require 'rails_helper'

RSpec.describe "Notifications", type: :request do
	describe 'httpレスポンスのテスト' do
		@notification = FactoryBot.create(:notification)
		context 'ログインなしでアクセス出来ないこと' do
			it 'Notifications/index' do
				get notifications_path
				expect(response).to have_http_status 302
			end
			
			it 'notification/destroy' do
				delete notification_path(id:Faker::Lorem.characters(number:10))
				expect(response).to have_http_status 302
			end
		end
	end
end
