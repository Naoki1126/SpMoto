class PostImage < ApplicationRecord
	has_many :post_image_images, dependent: :destroy
	accepts_attachments_for :post_image_images, attachment: :image
	has_many :hashtag_post_images
	has_many :hashtags, through: :hashtag_post_images
	belongs_to :user
	has_many :post_image_comments, dependent: :destroy
	has_many :post_image_favorites, dependent: :destroy
	has_many :notifications, dependent: :destroy
#いいね機能実装ののために必要
	def post_image_favorited_by?(user)
		post_image_favorites.where(user_id: user.id).exists?
	end
#PV数表示のための表記
	is_impressionable

#お知らせ機能
	def create_notification_favorite(current_user)
		#既にいいねされているか検索
		temp = Notification.where(["visitor_id = ? and visited_id = ? and post_image_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
		#いいねされていない場合のみ、通知レコードを作成
		if temp.blank?
			notification = current_user.active_notifications.new(
				post_image_id: id,
				visited_id: user_id,
				action; 'favorite'
			)
			#自分の投稿に対するいいねの場合は、通知済とする
			if notification.visitor_id == notification.visited_id
				notification.checked = true
			end
			notification.save if notification.valid?
		end
	end





	after_create do
		post_image = PostImage.find_by(id: self.id)
	#hashbodyに打ち込まれたハッシュタグを検出
		hashtags = self.hashbody.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
		hashtags.uniq.map do |hashtag|
	#ハッシュタグは先頭の#を外した上で保存
			tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
			post_image.hashtags << tag
		end
	end


	before_update do 
   		 post_image = PostImage.find_by(id: self.id)
   		 post_image.hashtags.clear
   		 hashtags = self.hashbody.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
   		 hashtags.uniq.map do |hashtag|
   	         tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
    	     post_image.hashtags << tag
    	 end
    end
end
