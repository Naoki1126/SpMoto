class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many :notifications, dependent: :destroy

  validates :content, presence: true
  scope :recent, -> { order(created_at: :desc) }

end
