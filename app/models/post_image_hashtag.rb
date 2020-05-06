class PostImageHashtag < ApplicationRecord
	belongs_to :post_image
	belongs_to :hashtag
	varidatates :post_image_id, presence: true
	varidates :Hashtag_id, presence: true
end
