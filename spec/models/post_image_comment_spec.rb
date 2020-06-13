require 'rails_helper'

RSpec.describe "PostImageCommentモデルのテスト", type: :model do
  	describe 'アソシエーションのテスト' do
		context 'Userモデルとの関係' do
			it 'N:1となっている' do
				expect(PostImageComment.reflect_on_association(:user).macro).to eq :belongs_to
			end
		end

		context 'PostImageモデルとの関係' do
			it 'N:1となっている' do
				expect(PostImageComment.reflect_on_association(:post_image).macro).to eq :belongs_to
			end
		end

		context 'Notificationモデルとの関係' do
			it '1:Nとなっている' do
				expect(PostImageComment.reflect_on_association(:notifications).macro).to eq :has_many
			end
		end
	end

	describe 'バリデーションのテスト' do
	 	before do
	 		@user =  FactoryBot.create(:user)
	 		@postimage = PostImage.create(
	 			user_id: @user.id,
	 			body: "ssssss",
	 			hashbody: "dddddd",
	 			)
	 		PostImageImage.create(
	 			post_image_id: @postimage.id,
	 			image_id: '111111')
	 		@comment = PostImageComment.create(
	 			user_id:@user.id,
	 			post_image_id:@postimage.id,
	 			comment:'aaaaaa',
	 			)
	 	end
			it '空欄でないこと' do
	 			@comment.comment = ''
	 			expect(@comment.valid?).to eq false;
	 		end
	end
end
