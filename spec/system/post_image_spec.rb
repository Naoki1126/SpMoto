require 'rails_helper'

describe '画像投稿システムのテスト' do
	let(:user) { create(:user) }
	before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'

  	end

  	describe'新規投稿ページ' do
  		before do
  			visit new_post_image_path
  		end

  		context '表示の確認' do

  			it '新規投稿と表示されること' do
  				expect(page).to have_content('新規投稿')
  			end

  			it '投稿の詳細を入力してくださいと表示されること' do
  				expect(page).to have_content('投稿の詳細を入力してください')
  			end

  			it 'ハッシュタグ入力欄と表示されること' do
  				expect(page).to have_content('ハッシュタグ入力欄')
  			end

  			it '新規投稿ボタンが表示されること' do
  				expect(page).to have_button('新規投稿')
  			end

  			it '画像選択フォームが表示されること' do
  				expect(page).to have_field 'post_image[post_image_images_images][]'
  			end

  			it '投稿詳細フォームが表示されること' do
  				expect(page).to have_field 'post_image[body]'
  			end

  			it 'ハッシュタグ入力フォームが表示されること' do
  				expect(page).to have_field 'post_image[hashbody]'
  			end
  		end

  		context '投稿機能' do

  			it '投稿に成功する' do
  				click_button '新規投稿'
  				expect(current_path).to eq(post_images_path)
  			end

  			it '投稿に失敗する' do
  				click_button '新規投稿'
  				expect(page).to have_content("エラー")
  			end
  		end
  	end

  	describe '投稿詳細ページ' do


	 	context '表示の確認' do
	 		it '投稿日付が表示されること' do
	 			visit new_post_image_path
	 			fill_in 'post_image_post_image_images_images',with: 'fwohewihfoifijiohif'
	 			fill_in 'post_image[body]',with: 'aaaaaaaa'
	 			fill_in 'post_image[hashbody]',with: '#aaaaaaaa'
	 			click_button '新規投稿'
	 			visit user_path(user)
	 			click_link post_image_path
	 			expect(page).to have_css('.image-show-day-edit')
	 		end

	 		it '画像が表示されること' do
	 			visit post_image_path(@postimage)
	 			expect(page).to have_css(".post_image_image")
	 		end
	 	end

	end

	describe '一覧画面の表示' do
		it '全投稿リンクが表示、リンク先が正しいこと' do
			visit post_images_path
			expect(page).to have_link '全投稿', href: post_images_path
			click_link '全投稿'
			expect(current_path).to eq(post_images_path)

		end

		it 'フォローリンクが表示、リンク先が正しいこと' do
			visit post_images_path
			expect(page).to have_link 'フォロー', href: post_images_path(user_id: user)
			click_link 'フォロー'
			expect(current_path).to eq(post_images_path)
		end
	end

end