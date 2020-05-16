class PostImageComment < ApplicationRecord
	belongs_to :user
	belongs_to :post_image
	has_many :notifications, dependent: :destroy

	def create_notification_comment!(current_user, post_image_comment_id)
		#自分位階にコメントしている人を全て取得し、全員に通知を送る
		temp_ids = Comment.select(:user_id).where(post_image_id: id).where.not(user_id: current_user.id).distinct
		temp_ids.each do |temp_id|
			save_nitification_comment!(current_user, comment_id, temp_id['user_id'])
		end
		#まだ誰もコメントしていない場合は、投稿者に通知を送る
		save_notification_comment!(current_user, comment_id user_id) if temp_ids.blank?
	end

	def save_notification_comment!(current_user, post_image_comment_id, visited_id)
		#コメントは複数回することが考えられるため、一つの投稿に複数回通知する。
		notification = current_user.active_notifications.new(
			post_image_id: id,
			post_image_comment_id: post_image_comment_id,
			visited_id: visited_id,
			action: 'post_image_comment'
		)
		#自分の投稿に対するコメントの場合は、通知済とする
		if notification.visitor_id == notification.visited_id
			notification.checked = true
		end
		notification.save if notification.valid?
	end
end
