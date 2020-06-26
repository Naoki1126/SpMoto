require 'rails_helper'

RSpec.describe "Homes", type: :request do
	describe 'httpレスポンスのテスト' do

		context 'ログインなしでアクセスできること' do
			it 'homes/top' do
				get root_path
				expect(response).to have_http_status 200
			end
		end
	end
end
