class PostImage < ApplicationRecord
	has_many :post_image_images, dependent: :destroy
	accepts_attachments_for :post_image_images, attachment: :image
	has_many :hashtag_post_images
	has_many :hashtags, through: :hashtag_post_images
	belongs_to :user
	has_many :post_image_comments, dependent: :destroy
	has_many :post_image_favorites, dependent: :destroy
	def post_image_favorited_by?(user)
		post_image_favorites.where(user_id: user.id).exists?
	end
	is_impressionable




	after_create do
		post_image = PostImage.find_by(id: self.id)
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
