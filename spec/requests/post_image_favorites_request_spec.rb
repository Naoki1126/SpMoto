require 'rails_helper'

RSpec.describe "PostImageFavorites", type: :request do
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
			it ' post_image_favorite/create' do
				post post_image_post_image_favorites_path(post_image_id: @postimage)
				expect(response).to have_http_status 302
			end

			it 'post_image_favorite/destroy' do
				delete post_image_post_image_favorites_path(post_image_id: @postimage)
				expect(response).to have_http_status 302
			end
		end


end
