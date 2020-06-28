require 'rails_helper'

describe '表示の確認' do
	let!(:user) { create(:user) }
	context '未ログイン時' do
		before do
			visit root_path
		end

		it '新規登録リンクが表示され、リンク先が正しい' do
			expect(page).to have_link '新規登録', href: new_user_registration_path
			find('.new').click
        	visit new_user_registration_path
		end

		it 'ログインリンクが表示され、リンク先が正しい' do
			expect(page).to have_link 'ログイン', href: new_user_session_path
			find('.session').click
        	visit new_user_session_path
		end

		it 'ゲストログインリンクが表示され、リンク先が正しい' do
			expect(page).to have_link 'ゲストログイン', href: homes_new_guest_path
			click_link 'ゲストログイン'
			expect(current_path).to eq(post_images_path)
		end

		it 'SpMotoとはが表示される' do
			 expect(page).to have_content("SpMotoとは")
		end
	end

	context 'ログイン時' do
		before do
			visit new_user_session_path
			fill_in 'user[email]', with: user.email
        	fill_in 'user[password]', with: user.password
        	click_button 'Log in'
        	visit root_path
		end
		it '新規登録リンクが表示されない' do
			expect(page).to have_no_link '新規登録', href: new_user_registration_path
		end

		it 'ログインリンクが表示されない' do
			expect(page).to have_no_link 'ログイン', href: new_user_session_path
		end

		it 'ゲストログインリンクが表示されない' do
			expect(page).to have_no_link 'ゲストログイン', href: homes_new_guest_path
		end

		it 'SpMotoとはが表示される' do
			 expect(page).to have_content("SpMotoとは")
		end
	end


end