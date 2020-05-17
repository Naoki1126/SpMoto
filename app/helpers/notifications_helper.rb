module NotificationsHelper
	def notification_form(notification)
		#通知を送ってきたユーザーを取得
		@visitor = notification.visitor
		#コメントの内容を通知に表示する
		@comment = nil
		@visitor_comment = notification.post_image_comment_id
		#notification.actionがfollowかfavoriteかcommentかで処理を変える
		case notification.action
		when 'follow'
			#aタグで通知を作成したユーザーshowのリンクを作成
			tag.a(notification.visitor.name, href: user_path(@visitor)) + 'があなたをフォローしました'
		when 'favorite'
			tag.a(notification.visitor.name, href: user_path(@visitor)) + 'が' + tag.a('あなたの投稿', href: post_image_path(notification.post_image.id)) + 'にいいねしました'
		when 'post_image_comment' then
			#コメントの内容と投稿のタイトルを取得
			@comment = PostImageComment.find_by(id: @visitor_comment)
			@comment_comment = @comment.comment
			@post_image_time = @comment.post_image.created_at
			tag.a(@visitor.name, href: user_path(@visitor)) + 'が' + tag.a("#{@post_image_time}の投稿に", href: post_image_path(notification.post_image_id)) + 'にコメントしました'
		end
	end


end
