require 'rails_helper'

RSpec.describe "Rooms", type: :request do


  context "ログインなしでアクセス出来ないこと" do
    it "rooms/index" do
      get rooms_path
      expect(response).to have_http_status 302
    end

    it 'rooms/create' do
    	post rooms_path
    	expect(response).to have_http_status 302
    end

    it 'rooms/show' do
    	get room_path(Faker::Lorem.characters(number:10))
    	expect(response).to have_http_status 302
    end

  end
end
