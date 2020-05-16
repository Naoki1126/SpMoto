class Notification < ApplicationRecord
	default_scope -> { order(created_at: :desc) }
	belongs_to :post_image, optional: true
	belongs_to :post_image_comment, optional: true
	belongs_to :event, optional: true
	belongs_tp :event_comment, optional: true

	belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
	belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true


end
