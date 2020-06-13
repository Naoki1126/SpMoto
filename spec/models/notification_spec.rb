require 'rails_helper'

RSpec.describe "Notificationモデルのテスト", type: :model do
	describe 'アソシエーションのテスト' do
		context 'PostImageモデルとの関係' do
			it 'N:1となっている' do
				expect(Notification.reflect_on_association(:post_image).macro).to eq :belongs_to
			end
		end

		context 'PostImageCommentモデルとの関係' do
			it 'N:1となっている' do
				expect(Notification.reflect_on_association(:post_image_comment).macro).to eq :belongs_to
			end
		end

		context 'Eventモデルとの関係' do
			it 'N:1となっている' do
				expect(Notification.reflect_on_association(:event).macro).to eq :belongs_to
			end
		end

		context 'EventCommentモデルとの関係' do
			it 'N:1となっている' do
				expect(Notification.reflect_on_association(:event_comment).macro).to eq :belongs_to
			end
		end

		context 'messageモデルとの関係' do
			it 'N:1となっている' do
				expect(Notification.reflect_on_association(:message).macro).to eq :belongs_to
			end
		end

		context 'Visitorモデルとの関係' do
			it 'N:1となっている' do
				expect(Notification.reflect_on_association(:visitor).macro).to eq :belongs_to
			end
		end

		context 'Visitedモデルとの関係' do
			it 'N:1となっている' do
				expect(Notification.reflect_on_association(:visited).macro).to eq :belongs_to
			end
		end
	end
end
