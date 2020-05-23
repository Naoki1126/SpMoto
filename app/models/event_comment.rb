class EventComment < ApplicationRecord
	validates :comment, presence: true
	belongs_to :user
	belongs_to :event
	has_many :notifications, dependent: :destroy
end
