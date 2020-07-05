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
  				fill_in 'event[title]',with: event.title
  				fill_in 'event[body]',with: event.body
  				select '北海道', from: 'event_prefecture_code'
  				fill_in 'event[date_and_time]',with: event.date_and_time
  				fill_in 'event[meetingfinishtime]', with: event.meetingfinishtime
  				fill_in 'event[meetingplace]', with: event.meetingplace
  				fill_in 'event[capacity]', with: event.capacity
  				fill_in 'event[latitude]', with: event.latitude
  				fill_in 'event[longitude]', with: event.longitude
  				click_button '上記内容で新規イベントを作成'
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
  				click_button '上記内容で新規イベントを作成'
  				expect(current_path).to eq(new_event_path)
  			end
  		end
  	end

  	describe 'イベントの編集' do
  		let!(:event) {create(:event,user: user)}
  		let!(:test_user2) {create(:test_user2)}
  		let!(:test_event2) {create(:test_event2,user:test_user2)}
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
  			it '開催エリアフォームが表示される' do
  				expect(page).to have_select 'event[prefecture_code]'
  			end
  			it '開催日時フォームに開催日時が表示される' do
  				expect(page).to have_css('#event_date_and_time'), with: event.date_and_time
  			end
  			it '終了時刻フォームに終了時刻が表示される' do
  				expect(page).to have_css("#event_meetingfinishtime"), with: event.meetingfinishtime
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
  			it '変更を保存するボタンが表示される' do
  				expect(page).to have_button('変更を保存する')
  			end
  			it 'このイベントを削除するボタンが表示される' do
  				expect(page).to have_link('このイベントを削除する')
  			end
  		end

  		context 'イベント編集アクション' do
  			it 'イベント編集成功' do
  				click_on '変更を保存する'
  				expect(current_path).to eq(events_path)
  			end
  			it 'イベント編集失敗' do
  				fill_in 'event[title]',with: ''
  				click_on '変更を保存する'
  				expect(page).to have_content('エラー')
  			end
  			it 'このイベントを削除するリンクが正しい' do
  				click_on 'このイベントを削除する'
  				expect(current_path).to eq(event_destroy_path(event))
  			end
  		end

  		context '他人のイベント編集ページへのアクセス' do
  			it 'アクセスできない' do
  				visit edit_event_path(test_event2)
  				expect(current_path).to eq(root_path)
  			end
  		end
  	end

  	describe 'イベント一覧ページ' do
  		let!(:event) {create(:event,user: user)}
  		let!(:test_user2) {create(:test_user2)}
  		before do
  			visit events_path
  		end
  		context '表示の確認' do
  			it 'レスポンシブ用のボタンが表示される' do
  				expect(page).to have_css('.which-pc')
  				expect(page).to have_css('.which-smart')
  			end
  			it '開催予定のイベントリンクのリンク先が正しい' do
  				expect(page).to have_link '開催予定のイベント', href: events_path(event_case:"now")
  			end
  			it '終了したイベントリンクのリンク先が正しい' do
  				expect(page).to have_link '終了したイベント', href: events_path(event_case:"log")
  			end
  			it 'イベント作成のリンク先が正しい' do
          expect(page).to have_link 'イベント作成', href: new_event_path
  			end
  			it 'カレンダーが表示される' do
  				expect(page).to have_css('.calender')
  			end
  			it '目的が表示される' do
  				expect(page).to have_content('目的')
  				expect(page).to have_content(event.title)
  			end
  			it '開催日時が表示される' do
  				expect(page).to have_content('開催日時')
  				expect(page).to have_content(event.date_and_time.strftime("%Y/%m/%d"))
  			end
  			it '終了日時が表示される' do
  				expect(page).to have_content('終了日時')
  				expect(page).to have_content(event.meetingfinishtime.strftime("%Y/%m/%d"))
  			end
  			it '都道府県が表示されリンク先が正しい' do
  				expect(page).to have_content('都道府県')
  				expect(page).to have_link event.prefecture_name,href: events_path(event_prefecture: 'name',prefecture_code: event.prefecture_code)
  			end
  			it '定員が表示される' do
  				expect(page).to have_content('定員')
  				expect(page).to have_content("#{event.capacity}人")
  			end
  			it '現在の参加人数が表示される' do
  				expect(page).to have_content('現在の参加人数')
  				expect(page).to have_content("#{event.event_participates.count}人")
  				click_on '0人'
  				expect(current_path).to eq(event_event_paricipates_path(event))
  			end
  			it '詳細リンクが表示されリンク先が正しい' do
  				expect(page).to have_content('詳細')
  				click_on '詳細'
  				expect(current_path).to eq(event_path(event))
  			end

  		end
  	end

  	describe 'イベント詳細ページ' do
  		let!(:event) {create(:event,user: user)}
  		let!(:test_user2) {create(:test_user2)}
  		let!(:test_event2) {create(:test_event2,user:test_user2)}
  		before do
  			visit event_path(event)
  		end

  		context '表示の確認' do
  			it 'Titleが表示される' do
  				expect(page).to have_content('Title')
  				expect(page).to have_content(event.title)
  			end
  			it 'イベント概要が表示される' do
  				expect(page).to have_content('イベント概要')
  				expect(page).to have_content(event.body)
  			end
  			it '主催者が表示され、リンク先が正しい' do
  				expect(page).to have_content('主催者')
  				expect(page).to have_content(user.profile_image)
  				expect(page).to have_content(user.name)
  				click_on user.name
  				expect(current_path).to eq(user_path(user))
  			end
  			it '開催エリアが表示される' do
  				expect(page).to have_content('開催エリア')
  				expect(page).to have_content(event.prefecture_name)
  			end
  			it '集合場所が表示される' do
  				expect(page).to have_content('集合場所')
  				expect(page).to have_content(event.meetingplace)
  			end
  			it '開催日時が表示される' do
  				expect(page).to have_content('開催日時')
  				expect(page).to have_content(event.date_and_time.strftime("%Y年%m月%d日%H時%M分"))
  			end
  			it '終了日時が表示される' do
  				expect(page).to have_content('終了日時')
  				expect(page).to have_content(event.meetingfinishtime.strftime("%Y年%m月%d日%H時%M分"))
  			end
  			it '定員が表示される' do
  				expect(page).to have_content('定員')
  				expect(page).to have_content(event.capacity)
  			end
  			it '現在の参加人数が表示される' do
  				expect(page).to have_content('現在の参加人数')
  				expect(page).to have_content(event.event_participates.count)
  				click_on '現在の参加人数'
  				expect(current_path).to eq(event_event_paricipates_path(event))
  			end
  			it '地図が表示される' do
  				expect(page).to have_css('#map')
  			end
  			it 'このイベントを編集するリンクが表示され、リンク先が正しい' do
  				expect(page).to have_link('このイベントを編集する')
  				click_on 'このイベントを編集する'
  				expect(current_path).to eq(edit_event_path(event))
  			end

  			it 'コメント欄とコメントフォーム表示される' do
  				expect(page).to have_content('コメントフォーム')
  				expect(page).to have_content('infomation')
  				expect(page).to have_field 'event_comment[comment]'
  			end
  		end
  	end

  	describe 'イベント削除ページ' do
  		let!(:event) {create(:event,user: user)}
  		let!(:test_user2) {create(:test_user2)}
  		let!(:test_event2) {create(:test_event2,user:test_user2)}
  		before do 
  			visit event_destroy_path(event)
  		end
  		context '表示の確認' do
  			it 'メッセージが表示される' do
  				expect(page).to have_content('このイベントを本当に削除しますか')
  			end
  			it '削除するボタンが表示される' do
  				expect(page).to have_link('削除する')
  			end
  			it '編集画面へ戻るボタンが表示され、リンク先が正しい' do
  				expect(page).to have_link('編集画面へ戻る')
  				click_on '編集画面へ戻る' 
  				expect(current_path).to eq(edit_event_path(event))
  			end
  		context 'イベントを削除することができる'
  			it '削除に成功する' do
  				click_on '削除する'
  				expect(current_path).to eq(events_path)
  				expect(page).to have_no_content(event.title)
  			end
  		end
  		context '他人のイベント削除' do
  			it '削除できない' do
  				visit event_destroy_path(test_event2)
  				click_on '削除する'
  				expect(current_path).to eq(root_path)
  			end
  		end
  	end
end
