class Event < ApplicationRecord
	belongs_to :user
	has_many :event_comments, dependent: :destroy
	has_many :event_participates, dependent: :destroy

  include JpPrefecture
  jp_prefecture :prefucture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

end
