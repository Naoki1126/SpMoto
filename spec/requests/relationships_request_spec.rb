require 'rails_helper'

RSpec.describe "Relationships", type: :request do

	let!(:user) { create(:user) }

		 context 'ログインなしでアクセス出来ないこと' do
			it ' relationships/create' do
				 post relationships_path
				expect(response).to have_http_status 302
			end

			it 'relationships/destroy' do
				delete relationship_path(Faker::Lorem.characters(number:10))
				expect(response).to have_http_status 302
			end
		end
end
