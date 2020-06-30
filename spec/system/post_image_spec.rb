require 'rails_helper'

describe '画像投稿システムのテスト' do
	let!(:user) { create(:user) }
	before do
	    visit new_user_session_path
	    fill_in 'user[email]', with: user.email
	    fill_in 'user[password]', with: user.password
	    click_button 'Log in'
	    @postimage = PostImage.new(
			 			user: user,
			 			body: "ssssss",
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
	 			body: "ssssss",
	 			hashbody: "dddddd",
	 			)
	 	@postimage2.post_image_images.build(
	 		post_image: @postimage2,
	 		image: "image-425.jpg")
	 	@postimage2.hashtags.build(
	 		hashname: 'ddddeedd')
	 	@postimage2.save
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
  		before do
			
		 	visit post_image_path(@postimage)
  		end

	 	context '表示の確認' do
	 		it '投稿日付が表示されること' do
	 			expect(page).to have_css('.image-show-day-edit')
	 		end
	 		it '編集するリンクが表示され、リンク先が正しいこと' do
	 			expect(page).to have_link '編集する', href:edit_post_image_path(@postimage)
	 			click_link '編集する'
	 			expect(current_path).to eq(edit_post_image_path(@postimage))
	 		end
	 		it '画像が表示されること' do
	 			expect(page).to have_css(".image-show-image")
	 		end
	 		it '投稿者の画像が表示されること' do
	 			expect(page).to have_css(".profile_image")
	 		end
	 		it '投稿者の名前が表示、リンク先が正しいこと' do
	 			expect(page).to have_link user.name
	 			click_on user.name
	 			expect(current_path).to eq(user_path(user))
	 		end
	 		it 'いいねボタンが存在すること' do
	 			expect(page).to have_css('.fa-heart-o')
	 		end
	 		it 'いいね数が表示されること' do
	 			expect(page).to have_content(@postimage.post_image_favorites.count)
	 		end
	 		it 'コメントアイコンが表示されること' do
	 			expect(page).to have_css('.fa-comments')
	 		end
	 		it 'コメント数が表示されること' do
	 			expect(page).to have_content(@postimage.post_image_comments.count)
	 		end
	 		it '投稿内容(body)が表示されること' do
	 			expect(page).to have_content(@postimage.body)
	 		end
	 		it 'ハッシュタグが表示されること' do
	 			expect(page).to have_content "dddddd"
	 		end
	 		it '閲覧数と表示されること' do
	 			expect(page).to have_content('閲覧数')
	 		end
	 		it 'いいね一覧が表示されること' do
	 			expect(page).to have_css('.favorite-modal')
	 		end
	 		it 'コメントフォームが表示されること' do
	 			expect(page).to have_css('.image-show-comment-box')
	 			expect(page).to have_content('Comment-form')
	 			expect(page).to have_css('.fa-window-close')
	 			expect(page).to have_field 'post_image_comment[comment]'
	 		end
	 	end

	 	context '他人の投稿詳細' do
	 		it '編集するリンクが表示されない' do
	 			visit post_image_path(@postimage2)
	 			expect(page).to have_no_link('編集する'), href:edit_post_image_path(@postimage2)
	 		end

	 		it '編集画面に行けない' do
	 			visit edit_post_image_path(@postimage2)
	 			expect(current_path).to eq(root_path)
	 		end
	 	end
	end
	describe '一覧画面の表示' do
		before do
			visit post_images_path
		end
		it '全投稿リンクが表示、リンク先が正しいこと' do
			expect(page).to have_link '全投稿', href: post_images_path
			click_link '全投稿'
			expect(current_path).to eq(post_images_path)
		end
		it 'フォローリンクが表示、リンク先が正しいこと' do
			expect(page).to have_link 'フォロー', href: post_images_path(user_id: user)
			click_link 'フォロー'
			expect(current_path).to eq(post_images_path)
		end
		it '投稿画像が表示されること' do
			expect(page).to have_css('.index-post-box-image')
		end
		it '投稿日付が表示されること' do
			expect(page).to have_content(@postimage.created_at.strftime("%Y/%m/%d"))
		end
		it 'コメントアイコンが表示されること' do
			expect(page).to have_css('.fa-comments')
		end
		it 'コメント数が表示されること' do
			expect(page).to have_content(@postimage.post_image_comments.count)
		end
		it 'いいねアイコンが表示されること' do
			expect(page).to have_css('.fa-heart-o')
		end
		it 'いいねの数が表示されること' do
			expect(page).to have_content(@postimage.post_image_favorites.count)
		end
		it '投稿者の写真が表示されること' do
			expect(page).to have_content(@postimage.user.profile_image)
		end
		it '投稿者の名前が表示されリンク先が正しいこと' do
			expect(page).to have_content(@postimage.user.name)
			click_link @postimage.user.name
			expect(current_path).to eq(user_path(@postimage.user))
		end
		it '投稿内容が50文字未満で表示されること' do
			expect(page).to have_content(@postimage.body.truncate(50))
		end
	end

	describe '投稿編集画面' do
		before do
			visit edit_post_image_path(@postimage)
		end
		context '編集画面の表示' do
			it '現在投稿されている画像が表示される' do
				expect(page).to have_css(".bxslider")
			end
			it '投稿編集と表示される' do
				expect(page).to have_content('投稿編集')
			end
			it 'bodyフィールドに文字が表示される' do
				expect(page).to have_field 'post_image[body]', with: @postimage.body
			end
			it 'ハッシュタグ入力欄と表示される' do
				expect(page).to have_content('ハッシュタグ入力欄')
			end
			it 'ハッシュタグ入力欄にハッシュタグが表示される' do
				expect(page).to have_field 'post_image[hashbody]'
			end
		end

		context '保存のテスト' do
			it '編集に成功する' do
				fill_in 'post_image[body]',with: "あ"
				click_on '保存'
				expect(current_path).to eq(post_image_path(@postimage))
				expect(page).to have_content('あ')
			end

			it '編集に失敗する' do
				fill_in 'post_image[body]',with: ""
				click_on '保存'
				expect(current_path).to eq(post_image_path(@postimage))
				expect(page).to have_content('エラー')
			end

		end

		context '削除のテスト' do
			it '削除に成功する' do
				click_on '削除'
				expect(page).to have_no_content('ssssss')
			end
		end
	end

end