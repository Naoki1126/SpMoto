require 'rails_helper'

RSpec.describe "Hashtagモデルのテスト", type: :model do
	describe 'アソシエーションのテスト' do
		context 'HashtagPostImageモデルとの関係' do
			it '1:Nとなっている' do
				expect(Hashtag.reflect_on_association(:hashtag_post_images).macro).to eq :has_many
			end
		end

		context 'PostImageモデルとの関係' do
			it '1:Nとなっている' do
				expect(Hashtag.reflect_on_association(:post_images).macro).to eq :has_many
			end
		end
	end

	describe 'バリデーションのテスト' do
	 	before do
	 		@hashtag = Hashtag.create(
	 			hashname: 'aaaaa')
	 	end
	 		context 'hashname' do
				it '空欄でないこと' do
	 				@hashtag.hashname = ''
	 				expect(@hashtag.valid?).to eq false;
	 			end

	 			it '50文字以下であること' do
	 				@hashtag.hashname = Faker::Lorem.characters(number:51)
	 				expect(@hashtag.valid?).to eq false;
	 			end
	 		end
	 end
end


