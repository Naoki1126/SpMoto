require 'rails_helper'

RSpec.describe "Events", type: :request do
	describe 'httpレスポンスのテスト' do

		before do
			@user = FactoryBot.create(:user)
			@event = FactoryBot.create(:event)
			allow_any_instance_of(ApplicationController).to receive(:current_user) { @user }
		end
		context 'events#new' do
			it 'events/newにアクセス出来ること' do

				get new_event_path
				expect(response).to have_http_status(200)
			end
		end

		context 'events#index' do
			it 'events/indexにアクセス出来ること' do
				get events_path
				expect(response).to have_http_status(200)
			end
		end

		context 'events#edit' do
			it 'events/editにアクセス出来ること' do
				get edit_event_path
				expect(response).to have_http_status(200)
			end
		end

		context 'events#show' do
			it 'events/showにアクセス出来ること' do
				get event_path(@event)
				expect(response).to have_http_status(200)
			end
		end

		context 'events#create' do
			it 'eventを作成できること' do
				post events_path
				expect(response).to have_http_status(200)
			end
		end

		context 'events#update' do
			it 'eventを更新できること' do
				patch event_path
				expect(response).to have_http_status(:success)
			end
		end
	end
end
