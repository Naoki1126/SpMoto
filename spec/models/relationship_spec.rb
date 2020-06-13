require 'rails_helper'

RSpec.describe "Relationshiモデルのテスト", type: :model do
  describe 'アソシエーションのテスト' do
		context 'Userモデルとの関係' do
			it 'N:1となっている' do
				expect(Relationship.reflect_on_association(:user).macro).to eq :belongs_to
			end
		end

		context 'Followモデルとの関係' do
			it 'N:1となっている' do
				expect(Relationship.reflect_on_association(:follow).macro).to eq :belongs_to
			end
		end
	end
	describe 'バリデーションのテスト' do
	 	before do
	 		@relationship =  Relationship.create(
	 			user_id: Faker::Lorem.characters(number:10),
	 			follow_id: Faker::Lorem.characters(number:10)
	 		)
	 	end

	 	context 'user_idカラム' do
			it '空欄でないこと' do
	 			@relationship.user_id = ''
	 			expect(@relationship.valid?).to eq false;
	 		end
	 	end

	 	context 'user_idカラム' do
			it '空欄でないこと' do
	 			@relationship.follow_id = ''
	 			expect(@relationship.valid?).to eq false;
	 		end
	 	end
	end
end
