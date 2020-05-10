class PostImageImage < ApplicationRecord
	belongs_to :post_image
	attachment :image
end
