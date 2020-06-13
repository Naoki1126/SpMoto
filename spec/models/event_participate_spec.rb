require 'rails_helper'

RSpec.describe "イベント参加", type: :model do
	describe 'アソシエーションのテスト' do
		context 'Userモデルとの関係' do
			it 'N:1となっている' do
				expect(EventParticipate.reflect_on_association(:user).macro).to eq :belongs_to
			end
		end

		context 'Eventモデルとの関係' do
			it 'N:1となっている' do
				expect(EventParticipate.reflect_on_association(:event).macro).to eq :belongs_to
			end
		end

	end


end
