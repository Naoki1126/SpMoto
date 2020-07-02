require 'rails_helper'

describe '検索システムのテスト' do
	let!(:user) { create(:user) }
	let!(:test_user3) {create(:test_user3)}
	let!(:test_user4) {create(:test_user4)}
	let!(:event) {create(:event)}
	let!(:test_event2) {create(:test_event2)}
	before do
		    visit new_user_session_path
		    fill_in 'user[email]', with: user.email
		    fill_in 'user[password]', with: user.password
		    click_button 'Log in'
		    @postimage = PostImage.new(
				 			user: user,
				 			body: "ssssssbbbb",
				 			hashbody: "dddddd",
				 			)
				 	@postimage.post_image_images.build(
				 		post_image: @postimage,
				 		image: "image-425.jpg")
				 	@postimage.hashtags.build(
				 		hashname: 'dddddd')
				 	@postimage.save

		 	@user = User.create(
		 		name: 'aaaaaaa',
		 		email: 'aaaaaaaaa@aa',
		 		password: '1111111111',
		 		password_confirmation: '1111111111')
		 		
		 	@postimage2 = PostImage.new(
		 			user: @user,
		 			body: "aaaaaa",
		 			hashbody: "aaaaaa",
		 			)
		 	@postimage2.post_image_images.build(
		 		post_image: @postimage2,
		 		image: "image-425.jpg")
		 	@postimage2.hashtags.build(
		 		hashname: 'ddddeedd')
		 	@postimage2.save
		 	visit search_path(search:"header")
	end
	context '検索をしていない状態の表示の確認' do
	 	it '検索フォームが表示される' do
	 		expect(page).to have_field 'search[content]'
	 	end
	 	it '検索対象セレクトが表示される' do
	 		expect(page).to have_select('search[model]', selected: [])
	 	end
	 	it '検索対象セレクトが表示される' do
	 		expect(page).to have_select('search[how]', selected: [])
	 	end
	 	it '検索ボタンが表示される' do
	 		expect(page).to have_button('検索')
	 	end
	end
	context 'Userの検索機能' do
		it 'Userを完全一致で検索できる' do
			fill_in 'search[content]',with: test_user3.name
			find("option[value='会員']").select_option
			find("option[value='match']").select_option
			click_button '検索'
			expect(page).to have_content('丸山')
		end
		it 'Userを前方一致で検索できる' do
			fill_in 'search[content]',with: '丸'
			find("option[value='会員']").select_option
			find("option[value='partical']").select_option
			click_button '検索'
			expect(page).to have_content('丸山')
		end
		it 'Userを後方一致で検索できる' do
			fill_in 'search[content]',with: '山'
			find("option[value='会員']").select_option
			find("option[value='partical']").select_option
			click_button '検索'
			expect(page).to have_content('丸山')
		end
	end

	context 'User検索の表示の確認' do
		before do
			fill_in 'search[content]',with: test_user3.name
			find("option[value='会員']").select_option
			find("option[value='match']").select_option
			click_button '検索'
		end
		it "search for 会員 と表示される" do
			expect(page).to have_content('search for')
			expect(page).to have_content('会員')
		end
		it 'imageと表示される' do
			expect(page).to have_content('image')
		end
		it 'nameと表示される' do
			expect(page).to have_content('name')
		end
		it 'prefectureと表示される' do
			expect(page).to have_content('prefecture')
		end
 		it 'Userのプロフィール写真が表示される' do
			expect(page).to have_css('.profile_image')
		end
		it 'Userの名前の表示、リンク先が正しい' do
			expect(page).to have_link test_user3.name,href: user_path(test_user3)
		end
		it 'Userの都道府県が表示される' do
			expect(page).to have_content(test_user3.prefecture_name)
		end
		it 'フォローボタンが表示される' do
			expect(page).to have_css('#new_relationship')
		end
		it 'フォローが成功する' do
			find("input[value='フォロー']").click
			expect(page).to have_no_button('#new_relationship')
		end
	end

	context 'イベント検索機能' do
		it 'イベントを完全一致で検索できること' do
			fill_in 'search[content]',with: 'ツーリング'
			find("option[value='イベント（目的）']").select_option
			find("option[value='match']").select_option
			click_button '検索'
			expect(page).to have_content(test_event2.title)
		end
		it 'イベントを前方一致で検索できること' do
			fill_in 'search[content]',with: 'ツ'
			find("option[value='イベント（目的）']").select_option
			find("option[value='partical']").select_option
			click_button '検索'
			expect(page).to have_content(test_event2.title)
		end
		it 'イベントを後方一致で検索できること' do
			fill_in 'search[content]',with: 'グ'
			find("option[value='イベント（目的）']").select_option
			find("option[value='partical']").select_option
			click_button '検索'
			expect(page).to have_content(test_event2.title)
		end
	end

	context 'イベント検索後の表示の確認' do
		before do
			fill_in 'search[content]',with: test_event2.title
			find("option[value='イベント（目的）']").select_option
			find("option[value='match']").select_option
			click_button '検索'
		end
        it 'serch for イベント（目的）と表示される' do
        	expect(page).to have_content('search for')
        	expect(page).to have_content('イベント（目的）')
        end
        it '目的と表示される' do
        	expect(page).to have_content('目的')
        end
        it '開催日時と表示される' do
        	expect(page).to have_content('開催日時')
        end
        it '終了日時と表示される' do
        	expect(page).to have_content('終了日時')
        end
        it '都道府県と表示される' do
        	expect(page).to have_content('都道府県')
        end
        it '定員と表示される' do
        	expect(page).to have_content('定員')
        end
        it '現在の参加人数と表示される' do
        	expect(page).to have_content('目的')
        end
        it '目的が表示される' do
        	expect(page).to have_content(test_event2.title)
        end
        it '開催日時が表示される' do
        	expect(page).to have_content(test_event2.date_and_time.strftime("%Y年%m月%d日"))
        end
        it '終了日時が表示される' do
        	expect(page).to have_content(test_event2.meetingfinishtime.strftime("%Y年%m月%d日"))
        end
        it '都道府県が表示され、リンク先が正しい' do
        	expect(page).to have_link test_event2.prefecture_name, href:events_path(event_prefecture: 'name',prefecture_code: test_event2.prefecture_code)
        end
        it '定員が表示される' do
        	expect(page).to have_content(test_event2.capacity)
        end
        it '現在の参加人数が表示され、リンク先が正しい' do
        	expect(page).to have_link test_event2.event_participates.count, href:event_event_paricipates_path(test_event2)
        end
        it '詳細と表示され、リンク先が正しい' do
        	expect(page).to have_link '詳細', href: event_path(test_event2)
        end
    end

    context '投稿内容検索機能' do
    	it '投稿内容を完全一致で検索できること' do
    		fill_in 'search[content]',with: 'ssssssbbbb'
			find("option[value='投稿内容']").select_option
			find("option[value='match']").select_option
			click_button '検索'
			expect(page).to have_content(@postimage.body)
		end
		it '投稿内容が前方一致で検索できること' do
			fill_in 'search[content]',with: 'ss'
			find("option[value='投稿内容']").select_option
			find("option[value='partical']").select_option
			click_button '検索'
			expect(page).to have_content(@postimage.body)
		end
		it '投稿内容が後方一致で検索できること' do
			fill_in 'search[content]',with: 'bb'
			find("option[value='投稿内容']").select_option
			find("option[value='partical']").select_option
			click_button '検索'
			expect(page).to have_content(@postimage.body)
		end
	end

	context '投稿内容検索後の表示の確認' do
		before do
			fill_in 'search[content]',with: 'ssssssbbbb'
			find("option[value='投稿内容']").select_option
			find("option[value='match']").select_option
			click_button '検索'
		end
		it 'search for 投稿内容に(検索値)が含まれる投稿が表示する' do
			expect(page).to have_content('search for')
			expect(page).to have_content('投稿内容に')
			expect(page).to have_content('ssssssbbbb')
			expect(page).to have_content('が含まれる投稿')
		end
		it '投稿の日付が表示される' do
			expect(page).to have_content(@postimage.created_at.strftime("%Y/%m/%d"))
		end
		it 'コメントのアイコンが表示される' do
			expect(page).to have_css('.fa-comments')
		end
		it 'コメントの数が表示される' do
			expect(page).to have_content(@postimage.post_image_comments.count)
		end
		it 'いいねボタンが表示される' do
			expect(page).to have_css('.fa-heart-o')
		end
		it 'いいねの数が表示される' do
			expect(page).to have_content(@postimage.post_image_favorites.count)
		end
		it '画像ボックスが表示される' do
			expect(page).to have_css('.post-image-index-post-box')
		end
		it '投稿者の写真が表示される' do
			expect(page).to have_content(@postimage.user.profile_image)
		end
		it '投稿者の名前が表示される' do
			expect(page).to have_content(@postimage.user.name)
		end
		it '投稿の本文が50文字未満で表示される' do
			expect(page).to have_content(@postimage.body.truncate(50))
		end
	end
	context 'ハッシュタグの検索機能' do
		it 'ハッシュタグを完全一致で検索できること' do
    		fill_in 'search[content]',with: 'dddddd'
			find("option[value='ハッシュタグ']").select_option
			find("option[value='match']").select_option
			click_button '検索'
			expect(page).to have_content(@postimage.body)
		end
	end

	context'ハッシュタグ検索後の投稿の表示' do
		before do
		 fill_in 'search[content]',with: 'dddddd'
			find("option[value='ハッシュタグ']").select_option
			find("option[value='match']").select_option
			click_button '検索'
		end
		it 'search for 投稿内容に(検索値)が含まれる投稿が表示する' do
			expect(page).to have_content('search for')
			expect(page).to have_content('#dddddd')
			expect(page).to have_content('が含まれる投稿')
		end
		it '投稿の日付が表示される' do
			expect(page).to have_content(@postimage.created_at.strftime("%Y/%m/%d"))
		end
		it 'コメントのアイコンが表示される' do
			expect(page).to have_css('.fa-comments')
		end
		it 'コメントの数が表示される' do
			expect(page).to have_content(@postimage.post_image_comments.count)
		end
		it 'いいねボタンが表示される' do
			expect(page).to have_css('.fa-heart-o')
		end
		it 'いいねの数が表示される' do
			expect(page).to have_content(@postimage.post_image_favorites.count)
		end
		it '画像ボックスが表示される' do
			expect(page).to have_css('.post-image-index-post-box')
		end
		it '投稿者の写真が表示される' do
			expect(page).to have_content(@postimage.user.profile_image)
		end
		it '投稿者の名前が表示される' do
			expect(page).to have_content(@postimage.user.name)
		end
		it '投稿の本文が50文字未満で表示される' do
			expect(page).to have_content(@postimage.body.truncate(50))
		end
	end


end