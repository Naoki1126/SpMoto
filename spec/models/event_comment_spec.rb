require 'rails_helper'

RSpec.describe 'EventCommentモデルのテスト', type: :model do

	describe 'アソシエーションのテスト' do
		context 'Userモデルとの関係' do
			it 'N:1となっている' do
				expect(EventComment.reflect_on_association(:user).macro).to eq :belongs_to
			end
		end

		context 'Eventモデルとの関係' do
			it 'N:1となっている' do
				expect(EventComment.reflect_on_association(:event).macro).to eq :belongs_to
			end
		end

		context 'Notificationモデルとの関係' do
			it '1:Nとなっている' do
				expect(EventComment.reflect_on_association(:notifications).macro).to eq :has_many
			end
		end
	end
end
