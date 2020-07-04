require 'rails_helper'

describe '未ログイン時のヘッダーのテスト' do
  before do
    visit root_path
  end

  context '表示項目' do

    it 'ロゴが表示され、リンク先が正しい' do
      expect(page).to have_link 'SpMoto', href: root_path
    end
    it 'トップリンクが表示される' do
      expect(page).to have_link 'トップ' , href: root_path
    end
    it '投稿一覧リンクが表示される' do
      expect(page).to have_link '投稿一覧', href: post_images_path
    end
    it 'イベントリンクが表示される' do
      expect(page).to have_link 'イベント', href: events_path
    end
    it '新規登録リンクが表示される' do
      expect(page).to have_link '新規登録', href: new_user_registration_path
    end
    it 'ログインと表示される' do
      expect(page).to have_link 'ログイン', href: new_user_session_path
    end
  end
end

describe 'ログイン後のヘッダー表示のテスト' do
  let(:user) { create(:user) }
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end
  context 'ロゴが表示され、リンク先が正しい' do
    it '正しい' do
      expect(page).to have_link 'SpMoto', href:root_path
    end
  end

  context 'ユーザー項目の確認' do
    it '主催イベントリンクが表示される' do
      expect(page).to have_link '主催イベント', href: events_path(event_case: "now",user_id: user.id)
    end
    it '過去イベントリンクが表示される' do
      expect(page).to have_link '過去イベント', href: events_path(event_case: "log",user_id: user.id)
    end
    it 'Followリンクが表示される' do
      expect(page).to have_link "Follow:#{user.followings.count}",href: user_follows_path(user_id: user.id)
    end
    it 'Followerリンクが表示される' do
      expect(page).to have_link "Follower:#{user.followers.count}", href: user_followers_path(user_id: user.id)
    end
    it 'DMリンクが表示される' do
      expect(page).to have_link 'DM', href: rooms_path
    end
    it '通知リンクが表示される' do
      expect(page).to have_link '通知', href: notifications_path
    end
  end
  context '一覧項目の確認' do
    it 'マイページリンクが表示される' do
      expect(page).to have_link 'マイページ', href: user_path(user.id)
    end
    it '投稿一覧リンクが表示される' do
      expect(page).to have_link '投稿一覧', href: post_images_path
    end
    it '会員一覧リンクが表示される' do
      expect(page).to have_link "会員一覧",href: users_path
    end
    it 'イベント一覧リンクが表示される' do
      expect(page).to have_link "イベント", href: events_path
    end
    it '新規投稿リンクが表示される' do
      expect(page).to have_link '新規投稿', href: new_post_image_path
    end
    it '検索リンクが表示される' do
      expect(page).to have_link '検索', href: search_path(search:"header")
    end
    it 'ハッシュタグリンクが表示される' do
      expect(page).to have_link '#', href: post_image_hashtag_path
    end
    it 'ログアウトリンクが表示される' do
      expect(page).to have_link 'ログアウト', href: destroy_user_session_path
    end
  end
end