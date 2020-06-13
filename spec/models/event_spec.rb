require 'rails_helper'

RSpec.describe 'Eventモデルのテスト', type: :model do
	describe 'アソシエーションのテスト' do
		context 'Userモデルとの関係' do
			it 'N:1となっている' do
				expect(Event.reflect_on_association(:user).macro).to eq :belongs_to
			end
		end

		context 'EventCommentsモデルとの関係' do
			it '1:Nとなっている' do
				expect(Event.reflect_on_association(:event_comments).macro).to eq :has_many
			end
		end

		context 'EventParticipatesモデルとの関係' do
			it '1:Nとなっている' do
				expect(Event.reflect_on_association(:event_participates).macro).to eq :has_many
			end
		end

		context 'Notificationsモデルとの関係' do
			it '1:Nとなっている' do
				expect(Event.reflect_on_association(:notifications).macro).to eq :has_many
			end
		end
	end

	describe 'バリデーションのテスト' do
	 	before do
	 		@event = FactoryBot.create(:event)
	 	end
			it 'titleが空欄でないこと' do
	 			@event.title = ''
	 			expect(@event.valid?).to eq false;
	 		end

	 		it 'bodyが空欄でないこと' do
	 			@event.body = ''
	 			expect(@event.valid?).to eq false;
	 		end

	 		it 'bodyが400文字以下であること' do
	 			@event.body = Faker::Lorem.characters(number:401)
	 			expect(@event.valid?).to eq false;
	 		end

	 		it 'prefecture_codeが空欄でないこと' do
	 			@event.prefecture_code = ''
	 			expect(@event.valid?).to eq false;
	 		end

	 		it 'date_and_timeが空欄でないこと' do
	 			@event.date_and_time = ''
	 			expect(@event.valid?).to eq false;
	 		end

	 		it 'meetingplaceが空欄でないこと' do
	 			@event.meetingplace = ''
	 			expect(@event.valid?).to eq false;
	 		end

	 		it 'meetingfinishtimeが空欄でないこと' do
	 			@event.meetingfinishtime = ''
	 			expect(@event.valid?).to eq false;
	 		end

	 		it 'latitudeが空欄でないこと' do
	 			@event.latitude = ''
	 			expect(@event.valid?).to eq false;
	 		end

	 		it 'longitudeが空欄でないこと' do
	 			@event.longitude = ''
	 			expect(@event.valid?).to eq false;
	 		end

	 		it 'capaticyが空欄でないこと' do
	 			@event.capacity = ''
	 			expect(@event.valid?).to eq false;
	 		end
	end
end
