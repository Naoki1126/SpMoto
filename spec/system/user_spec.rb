require 'rails_helper'

describe 'ユーザー認証のテスト' do
	let!(:user) { create(:user) }
	context '新規登録' do
		before do
			visit '/users/sign_up'
		end
		it '新規登録に成功' do
			fill_in 'user[name]', with: Faker::Lorem.characters(number:10)
			fill_in 'user[email]', with: Faker::Internet.email
      select '北海道', from: 'user_prefecture_code'
			fill_in 'user[password]', with: user.password
			fill_in 'user[password_confirmation]', with:user.password_confirmation
			click_button 'Sign up'
			expect(current_path).to eq(post_images_path)
		end

		it '新規登録に失敗' do
			fill_in 'user[name]', with: ''
			fill_in 'user[email]', with: ''
		  select '北海道', from: 'user_prefecture_code'
			fill_in 'user[password]', with: 123123
			fill_in 'user[password_confirmation]', with: 123123
			click_button 'Sign up'
			expect(page).to have_content 'error'
		end
	end	

  context 'ログイン' do
    before do
      visit new_user_session_path
    end
      it 'ログインに成功する' do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'Log in'
        expect(current_path).to eq(post_images_path)
      end

      it 'ログインに失敗する' do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'Log in'
        expect(current_path).to eq(new_user_session_path)
      end
  end
end


describe 'ユーザーのテスト' do
  let(:user) { create(:user) }
  let!(:test_user2) { create(:user) }
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end
  describe 'マイページのテスト' do
    context '表示の確認' do
      it 'プロフィール画像が表示される' do
        visit user_path(user)
        expect(page).to have_css('.profile_image')
      end
      it '名前が表示される' do
        visit user_path(user)
        expect(page).to have_content(user.name)
      end
      it '都道府県が表示される' do
        visit user_path(user)
        expect(page).to have_content(user.prefecture_name)
      end
      it '自己紹介が表示される' do
        visit user_path(user)
        expect(page).to have_content(user.introduction)
      end
      it '編集リンクが表示される' do
        visit user_path(user)
        expect(page).to have_link '', href: edit_user_path(user)
      end
      it '投稿件数が表示される' do
        visit user_path(user)
        expect(page).to have_content(user.post_images.count)
      end
      it '主催イベントリンクが表示される' do
        visit user_path(user)
        expect(page).to have_link '主催イベント', href: events_path(event_case: "now",user_id: user.id)
      end
      it '過去イベントリンクが表示される' do
        visit user_path(user)
        expect(page).to have_link '過去イベント', href: events_path(event_case: "log",user_id: user.id)
      end
      it 'Followリンクが表示される' do
        visit user_path(user)
        expect(page).to have_link "Follow:#{user.followings.count}",href: user_follows_path(user_id: user.id)
      end
      it 'Followerリンクが表示される' do
        visit user_path(user)
        expect(page).to have_link "Follower:#{user.followers.count}", href: user_followers_path(user_id: user.id)
      end
      it 'DMリンクが表示される' do
        visit user_path(user)
        expect(page).to have_link 'DM', href: rooms_path
      end
      it '通知リンクが表示される' do
        visit user_path(user)
        expect(page).to have_link '通知', href: notifications_path
      end
      it '投稿画像が表示される' do
        visit user_path(user)
        expect(page).to have_css('.contents-box')
      end
      it 'カレンダーアイコンが表示される' do
        visit user_path(user)
        expect(page).to have_css('.fa-calendar')
      end
      it 'カレンダーが表示される' do
        visit user_path(user)
        expect(page).to have_css('.simple-calendar')
      end
    end
  end

  describe '編集ページのテスト' do
    context '自分の編集画面への遷移' do
      it '遷移できる' do
        visit edit_user_path(user)
        expect(current_path).to eq('/users/' + user.id.to_s + '/edit')
      end
    end
    context '他人の編集画面への遷移' do
      it '遷移できない' do
        visit edit_user_path(test_user2)
        expect(current_path).to eq('/')
      end
    end
    context '編集が成功する' do
      it '成功' do
        visit edit_user_path(user)
        click_button '変更を保存する'
        expect(current_path).to eq(user_path(user))
      end
    end
    context '編集が失敗する' do
      it '失敗' do
        visit edit_user_path(user)
        click_button '変更を保存する'
        expect(current_path).to eq(user_path(user))
      end
    end
    context '退会' do
      it '退会リンクのリンク先が正しい' do
        visit edit_user_path(user)
        click_link '退会する'
        expect(current_path).to eq(user_destroy_path(user))
      end

      it '退会するリンク先が正しい' do
        visit user_destroy_path(user)
        click_link '退会する'
        expect(current_path).to eq(root_path)
      end

      it '退会しないリンク先が正しい' do
        visit user_destroy_path(user)
        click_link '退会しない'
        expect(current_path).to eq(user_path(user))
      end
    end

    context '表示の確認' do
      before do
        visit edit_user_path(user)
      end
      it 'プロフィール画像投稿フォームが表示される' do
         expect(page).to have_field 'user[profile_image]'
      end
      it '名前編集フォームに自分の名前が表示される' do
        expect(page).to have_field 'user[name]', with: user.name
      end
      it '都道府県フォームが表示される' do
        expect(page).to have_select 'user[prefecture_name]'
      end

      it '自己紹介フォームに自分の自己紹介が表示される' do
        expect(page).to have_field 'user[introduction]', with: user.introduction
      end

      it '現在設定しているプロフィール画像が表示される' do
        expect(page).to have_css(".profile_image")
      end
    end
        

  end
end


