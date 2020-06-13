require 'rails_helper'

RSpec.describe "HashtagPostImageモデルのテスト", type: :model do
  describe 'アソシエーションのテスト' do
		context 'Hashtagモデルとの関係' do
			it 'N:1となっている' do
				expect(HashtagPostImage.reflect_on_association(:hashtag).macro).to eq :belongs_to
			end
		end

		context 'PostImageモデルとの関係' do
			it 'N:1となっている' do
				expect(HashtagPostImage.reflect_on_association(:post_image).macro).to eq :belongs_to
			end
		end
	end

	describe 'バリデーションのテスト' do
	 	before do
	 		@hashtag = HashtagPostImage.create(
	 			post_image_id: Faker::Lorem.characters(number:10),
	 			hashtag_id: Faker::Lorem.characters(number:10)
	 			)
	 	end
	 		context 'post_image_id' do
				it '空欄でないこと' do
	 				@hashtag.post_image_id = ''
	 				expect(@hashtag.valid?).to eq false;
	 			end
	 		end

	 		context 'hashtag_id' do

	 			it '空欄でないこと' do
	 				@hashtag.hashtag_id = ''
	 				expect(@hashtag.valid?).to eq false;
	 			end
	 		end
	 end
end
