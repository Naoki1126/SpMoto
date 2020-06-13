require 'rails_helper'

RSpec.describe "PostImageImageモデルのテスト", type: :model do
	describe 'アソシエーションのテスト' do
		context 'PostImageモデルとの関係' do
			it 'N:1となっている' do
				expect(PostImageImage.reflect_on_association(:post_image).macro).to eq :belongs_to
			end
		end
	end
  
end
