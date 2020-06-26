require 'rails_helper'

RSpec.describe "PostImageComments", type: :request do
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
			it ' post_image_comment/create' do
				 post post_image_post_image_comments_path(post_image_id: @postimage)
				expect(response).to have_http_status 302
			end

			it 'post_image_comment/destroy' do
				delete post_image_post_image_comments_path(post_image_id: @postimage)
				expect(response).to have_http_status 302
			end
		end
end
