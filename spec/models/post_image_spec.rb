require 'rails_helper'

RSpec.describe 'PostImageモデルのテスト', type: :model do

	describe 'アソシエーションのテスト' do
		context 'Userモデルとの関係' do
			it 'N:1となっている' do
				expect(PostImage.reflect_on_association(:user).macro).to eq :belongs_to
			end
		end

		context 'PostImageCommentsモデルとの関係' do
			it '1:Nとなっている' do
				expect(PostImage.reflect_on_association(:post_image_comments).macro).to eq :has_many
			end
		end

		context 'PostImageFavoriteモデルとの関係' do
			it '1:Nとなっている' do
				expect(PostImage.reflect_on_association(:post_image_favorites).macro).to eq :has_many
			end
		end

		context 'Notificationsモデルとの関係' do
			it '1:Nとなっている' do
				expect(PostImage.reflect_on_association(:notifications).macro).to eq :has_many
			end
		end

		context 'PostImageImagesモデルとの関係' do
			it '1:Nとなっている' do
				expect(PostImage.reflect_on_association(:post_image_images).macro).to eq :has_many
			end
		end

		context 'Hashtagsモデルとの関係' do
			it '1:Nとなっている' do
				expect(PostImage.reflect_on_association(:hashtags).macro).to eq :has_many
			end
		end
		context 'HashtagPostImagesモデルとの関係' do
			it '1:Nとなっている' do
				expect(PostImage.reflect_on_association(:hashtag_post_images).macro).to eq :has_many
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
	 	end
			it 'bodyが空欄でないこと' do
	 			@postimage.body = ''
	 			expect(@postimage.valid?).to eq false;
	 		end

	 		it 'bodyが200文字以下であること' do
	 			@postimage.body = Faker::Lorem.characters(number:201)
	 			expect(@postimage.valid?).to eq false;
	 		end

	 		it '添付画像があること' do
	 			@postimage.post_image_image_ids = ""
	 			expect(@postimage.valid?).to eq false;
	 		end

	end

end
