require 'rails_helper'

describe 'イベントシステムのテスト' do
	let(:user) { create(:user) }
	before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  	end

  	describe '新規イベントの作成' do
  		let!(:event) {create(:event,user: user)}
  		before do
  			visit new_event_path
  		end

  		context '表示の確認' do
  			it '新規イベントと表示される' do
  				expect(page).to have_content("新規イベント")
  			end

  			it 'Titleと表示される' do
  				expect(page).to have_content("Title")
  			end

  			it 'イベント概要と表示される' do
  				expect(page).to have_content("イベント概要")
  			end

  			it '開催エリアと表示される' do
  				expect(page).to have_content("開催エリア")
  			end

  			it '開催日時と表示される' do
  				expect(page).to have_content("開催日時")
  			end

  			it '終了日時と表示される' do
  				expect(page).to have_content("終了日時")
  			end

  			it '集合場所と表示される' do
  				expect(page).to have_content("集合場所")
  			end

  			it '地図が表示される' do
  				expect(page).to have_css('#map')
  			end

  			it 'Titleフォームが表示される' do
  				expect(page).to have_field "event[title]"
  			end

  			it 'イベント概要フォームが表示される' do
  				expect(page).to have_field "event[body]"
  			end

  			it '開催エリアフォームが表示される' do
  				expect(page).to have_select "event[prefecture_code]"
  			end

  			it '開催日時フォームが表示される' do
  				expect(page).to have_field "event[date_and_time]"
  			end

  			it '終了日時フォームが表示される' do
  				expect(page).to have_field "event[meetingfinishtime]"
  			end

  			it '集合場所フォームが表示される' do
  				expect(page).to have_field "event[meetingplace]"
  			end

  			it '定員フォームが表示される' do
  				expect(page).to have_field "event[capacity]"
  			end

  			it 'イベント作成ボタンが表示される' do
  				expect(page).to have_button '上記内容で新規イベントを作成'
  			end
  		end

  		context '作成アクション' do
  			it '作成に成功する' do
  				visit new_event_path
  				fill_in 'event[title]',with: event.title
  				fill_in 'event[body]',with: event.body
  				select '北海道', from: 'event_prefecture_code'
  				fill_in 'event[date_and_time]',with: event.date_and_time
  				fill_in 'event[meetingfinishtime]', with: event.meetingfinishtime
  				fill_in 'event[meetingplace]', with: event.meetingplace
  				fill_in 'event[capacity]', with: event.capacity
  				fill_in 'event[latitude]', with: event.latitude
  				fill_in 'event[longitude]', with: event.longitude
  				click_on '上記内容で新規イベントを作成'
  				expect(current_path).to eq(events_path)
  			end

  			it '作成に失敗する' do
  				fill_in 'event[title]',with: ""
  				fill_in 'event[body]',with: ""
  				select '北海道', from: 'event_prefecture_code'
  				fill_in 'event[date_and_time]',with: event.date_and_time
  				fill_in 'event[meetingfinishtime]', with: event.meetingfinishtime
  				fill_in 'event[meetingplace]', with: event.meetingplace
  				fill_in 'event[capacity]', with: event.capacity
  				fill_in 'event[latitude]', with: event.latitude
  				fill_in 'event[longitude]', with: event.longitude
  				click_on '上記内容で新規イベントを作成'
  				expect(current_path).to eq(new_event_path)
  			end
  		end
  	end

  	describe 'イベントの編集' do
  		let!(:event) {create(:event,user: user)}
  		before do
  			visit edit_event_path(event)
  		end
  		context '表示の確認' do
  			it 'イベント編集と表示される' do
  				expect(page).to have_content("イベント編集")
  			end
  			it 'Titleと表示される' do
  				expect(page).to have_content("Title")
  			end
  			it 'イベント概要と表示される' do
  				expect(page).to have_content("イベント概要")
  			end
  			it '開催エリアと表示される' do
  				expect(page).to have_content("開催エリア")
  			end
  			it '開催日時と表示される' do
  				expect(page).to have_content("開催日時")
  			end
  			it '終了日時と表示される' do
  				expect(page).to have_content("終了時刻")
  			end
  			it '集合場所と表示される' do
  				expect(page).to have_content("集合場所")
  			end
  			it '定員と表示される' do
  				expect(page).to have_content("定員")
  			end
  			it '変更を保存するボタンが表示される' do
  				expect(page).to have_button("変更を保存する")
  			end
  			it 'このイベントを削除するボタンが表示される' do
  				expect(page).to have_link("このイベントを削除する")
  			end
  			it' TitleフォームにTitleが表示される' do
  				expect(page).to have_field 'event[title]', with: event.title
  			end
  			it 'イベント概要フォームに概要が表示される' do
  				expect(page).to have_field 'event[body]', with: event.body
  			end
  			it '開催エリアに開催エリアが表示される' do
  				expect(page).to have_select 'event[prefecture_code]', with: event.prefecture_code
  			end
  			it '開催日時フォームに開催日時が表示される' do
  				expect(page).to have_field 'event[date_and_time]', with: event.date_and_time
  			end
  			it '終了時刻フォームに終了時刻が表示される' do
  				expect(page).to have_field 'event[meetingfinishtime]', with: event.meetingfinishtime
  			end
  			it '集合場所に集合場所が表示される' do
  				expect(page).to have_field 'event[meetingplace]', with: event.meetingplace
  			end
  			it '定員フォームが表示される' do
  				expect(page).to have_field 'event[capacity]'
  			end
  			it '経度フォームに経度が表示される' do
  				expect(page).to have_field 'event[latitude]', with: event.latitude
  			end
  			it '緯度フォームに緯度が表示される' do
  				expect(page).to have_field 'event[longitude]', with: event.longitude
  			end
  			it '地図が表示される' do
  				expect(page).to have_css('#map')
  			end

  		end
  	end
end
