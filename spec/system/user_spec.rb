require 'rails_helper'

describe 'ユーザー認証のテスト' do
	let!(:user) { create(:user) }
	context '新規登録' do
		before do
			visit new_user_registration_path
		end
		it '新規登録に成功' do
			
			fill_in 'user[name]', with: Faker::Lorem.characters(number:10)
			fill_in 'user[email]', with: Faker::Internet.email
			fill_in 'user[prefecture_code]', with: Faker::Lorem.characters(number:2)
			fill_in 'user[password]', with: 123123
			fill_in 'user[password_cofirmation', with: 123123
			click_button 'Sign up'
			expect(current_path).to eq(post_images_path)
		end

		it '新規登録に失敗' do
			fill_in 'user[name', with: ''
			fill_in 'user[email]', with: ''
			fill_in 'user[prefecture_code]', with: Faker::Lorem.characters(number:2)
			fill_in 'user[password]', with: 123123
			fill_in 'user[password_cofirmation', with: 123123
			click_button 'Sign up'
			expect(page).to have_content 'error'
		end
	end	
end