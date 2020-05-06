class PostImage < ApplicationRecord
	mount_uploaders :images, ImageUploader
	has_and_belongs_to_many :hashtags
	belongs_to :user
	has_many :post_image_comments, dependent: :destroy
	has_many :post_image_favorites, dependent: :destroy


	after_create do
		post_image = PostImage.find_by(id: self.id)
		hashtags = self.content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
		hashtags.uniq.map do |hashtag|
			#ハッシュタグは先頭の#を外した上で保存
			tag = Hashtag.find_or_create_by(hashname: hashtg.downcase.delite('#'))
			post_image.hashtags << tag
		end
	end


	before_update do 
   		 post_image = PostImage.find_by(id: self.id)
   		 post_image.hashtags.clear
   		 hashtags = self.content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
   		 hashtags.uniq.map do |hashtag|
   	         tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
    	     micropost.hashtags << tag
    end
end
