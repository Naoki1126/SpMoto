class PostImageComment < ApplicationRecord
  validates :comment, presence: true
  belongs_to :user
  belongs_to :post_image
  has_many :notifications, dependent: :destroy
end
