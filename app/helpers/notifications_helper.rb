module NotificationsHelper
  def notification_form(notification)
    # 通知を送ってきたユーザーを取得
    @visitor = notification.visitor
    @comment = nil

    # notification.actionがfollowかfavoriteかcommentかで処理を変える
    case notification.action
    when 'follow'
      # aタグで通知を作成したユーザーshowのリンクを作成
      tag.a(notification.visitor.name, href: user_path(@visitor)) + 'があなたをフォローしました'
    when 'favorite'
      @post_image = notification.post_image
      @user = @post_image.user
      @time = @post_image.created_at.strftime("%Y-%m-%d(%a)")
      tag.a(notification.visitor.name, href: user_path(@visitor)) + 'が' + tag.a("#{@user.name}の#{@time}の投稿", href: post_image_path(notification.post_image.id)) + 'にいいねしました'
    when 'post_image_comment'
      # コメントの内容と投稿を取得
      @visitor_post_image_comment = notification.post_image_comment_id
      @comment = PostImageComment.find_by(id: @visitor_comment)
      @post_image_time = notification.post_image.created_at.strftime("%Y-%m-%d(%a)")
      tag.a(@visitor.name, href: user_path(@visitor)) + 'が' + tag.a("#{@post_image_time}の投稿", href: post_image_path(notification.post_image_id)) + 'にコメントしました'
    when 'participate'
      tag.a(notification.visitor.name, href: user_path(@visitor)) + 'が' + tag.a('あなたのイベント', href: event_path(notification.event.id)) + 'に参加予定です'
    when 'event_comment' 
      @visitor_event_comment = notification.event_comment_id
      @eventcomment = EventComment.find_by(id: @visitor_event_comment)
      @eventtitle = notification.event.title
      @user = notification.event.user
      tag.a(@visitor.name, href: user_path(@visitor)) + "が#{@user.name}の" + tag.a("#{@eventtitle}イベント", href: event_path(notification.event_id)) + 'にコメントしました'
    end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
