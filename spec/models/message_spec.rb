require 'rails_helper'

RSpec.describe "Messageモデルのテスト", type: :model do
  
  describe 'アソシエーションのテスト' do
		context 'Userモデルとの関係' do
			it 'N:1となっている' do
				expect(Message.reflect_on_association(:user).macro).to eq :belongs_to
			end
		end

		context 'Roomモデルとの関係' do
			it 'N:1となっている' do
				expect(Message.reflect_on_association(:room).macro).to eq :belongs_to
			end
		end

		context 'Notificationモデルとの関係' do
			it '1:Nとなっている' do
				expect(Message.reflect_on_association(:notifications).macro).to eq :has_many
			end
		end
	end

	describe 'バリデーションのテスト' do
	 	before do
	 		@user = FactoryBot.create(:user)
	 		@room = FactoryBot.create(:room)
	 		@message = Message.create(
	 			user_id: @user.id,
	 			room_id: @room.id,
	 			content: Faker::Lorem.characters(number:10))
	 	end
			it 'contentが空欄でないこと' do
	 			@message.content = ''
	 			expect(@message.valid?).to eq false;
	 		end
	 end
end
