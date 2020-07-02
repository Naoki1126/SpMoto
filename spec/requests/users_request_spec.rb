require 'rails_helper'

RSpec.describe "Users", type: :request do
	let!(:user) { create(:user) }

		context 'ログインなしでアクセス出来ないこと' do
			it ' users/follows' do
				 get user_follows_path(user_id: user)
				expect(response).to have_http_status 302
			end

			it 'users/followers' do
				get user_followers_path(user_id: user)
				expect(response).to have_http_status 302
			end

			it 'users/index' do
				get users_path
				expect(response).to have_http_status 302
			end

			it 'users/edit' do
				get edit_user_path(id: user)
				expect(response).to have_http_status 302
			end

			it 'users/show' do
				get user_path(id:user)
				expect(response).to have_http_status 302
			end

			it 'users/update' do
				patch user_path(id:user)
				expect(response).to have_http_status 302
			end

			it 'users/destroy' do
				delete user_path(id:user)
				expect(response).to have_http_status 302
			end

			it 'users/destroy_page' do
				get user_destroy_path(id:user)
				expect(response).to have_http_status 302
			end
		end
end
