require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
	describe 'アソシエーションのテスト' do
		context 'PostImageモデルとの関係' do
			it '1:Nとなっている' do
				expect(User.reflect_on_association(:post_images).macro).to eq :has_many
			end
		end

		context 'PostImageCommentモデルとの関係' do
			it '1:Nとなっている' do
				expect(User.reflect_on_association(:post_image_comments).macro).to eq :has_many
			end
		end

		context 'PostImageFavoriteモデルとの関係' do
			it '1:Nとなっている' do
				expect(User.reflect_on_association(:post_image_favorites).macro).to eq :has_many
			end
		end

		context 'Eventモデルとの関係' do
			it '1:Nとなっている' do
				expect(User.reflect_on_association(:events).macro).to eq :has_many
			end
		end

		context 'EventCommentモデルとの関係' do
			it '1:Nとなっている' do
				expect(User.reflect_on_association(:event_comments).macro).to eq :has_many
			end
		end

		context 'EventParticipateモデルとの関係' do
			it '1:Nとなっている' do
				expect(User.reflect_on_association(:event_participates).macro).to eq :has_many
			end
		end


		context 'Relationshipモデルとの関係' do
			it '1:Nとなっている' do
				expect(User.reflect_on_association(:relationships).macro).to eq :has_many
			end
		end

		context 'Messageモデルとの関係' do
			it '1:Nとなっている' do
				expect(User.reflect_on_association(:messages).macro).to eq :has_many
			end
		end

		context 'Entryモデルとの関係' do
			it '1:Nとなっている' do
				expect(User.reflect_on_association(:entries).macro).to eq :has_many
			end
		end

		context 'Roomモデルとの関係' do
			it '1:Nとなっている' do
				expect(User.reflect_on_association(:rooms).macro).to eq :has_many
			end
		end
	end


	describe 'バリデーションのテスト' do
	 	before do
	 		@user =  FactoryBot.create(:user)
	 	end

	 	context 'nameカラム' do
			it '空欄でないこと' do
	 			@user.name = ''
	 			expect(@user.valid?).to eq false;
	 		end
	 		it '2文字以上であること' do
	 			@user.name = 'a'
	 			expect(@user.valid?).to eq false;
	 		end

	 		it '20文字以下であること' do
	 			@user.name = Faker::Lorem.characters(number:21)
	 			expect(@user.valid?).to eq false;
	 		end
	 	end

	 	context 'introductionカラム' do
	 		it '150文字以下であること' do
	 			@user.introduction = Faker::Lorem.characters(number:151)
	 			expect(@user.valid?).to eq false;
	 		end
	 	end

	end

  
end
