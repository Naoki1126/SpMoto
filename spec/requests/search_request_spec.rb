require 'rails_helper'

RSpec.describe "Searches", type: :request do
	context "ログインなしでアクセス出来ないこと" do
	    it "search/search" do
	      get search_path
	      expect(response).to have_http_status 302
	    end
  	end
end
