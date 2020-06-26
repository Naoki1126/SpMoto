require 'rails_helper'

RSpec.describe "PostImages", type: :request do

	describe 'httpレスポンスのテスト' do
		let!(:user) { create(:user) }
		before do
			@postimage = PostImage.create(
					id:Faker::Lorem.characters(number:10),
		 			user_id: user.id,
		 			body: "ssssss",
		 			hashbody: "dddddd",
		 			)
		 		PostImageImage.create(
		 			post_image_id: @postimage.id,
		 			image_id: '111111')
		 end

		context 'ログインなしでアクセス出来ないこと' do
			it ' post_image/new' do
				get new_post_image_path
				expect(response).to have_http_status 302
			end

			it 'post_image/edit' do
				get edit_post_image_path(id:@postimage)
				expect(response).to have_http_status 302
			end

			it 'post_image/show' do
				get post_image_path(id:@postimage)
				expect(response).to have_http_status 302
			end

			it 'post_image/create' do
				post post_images_path
				expect(response).to have_http_status 302
			end

			it 'post_image/update' do
				patch post_image_path(id:@postimage)
				expect(response).to have_http_status 302
			end

			it 'post_image/destroy' do 
				delete post_image_path(id:@postimage)
				expect(response).to have_http_status 302
			end
		end

		context 'ログインなしでアクセスできること' do
			it 'post_image/index' do
				get post_images_path
				expect(response).to have_http_status 200
			end
		end

	end
end
