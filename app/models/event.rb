class Event < ApplicationRecord
  validates :title, presence: true
  validates :body, length: { in: 1..400 }
  validates :prefecture_code, presence: true
  validates :date_and_time, presence: true
  validates :meetingplace, presence: true
  validates :meetingfinishtime, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :capacity, presence: true

  belongs_to :user
  has_many :event_comments, dependent: :destroy
  has_many :event_participates, dependent: :destroy
  has_many :notifications, dependent: :destroy
  #既に参加アクションをしているか判断
  def participated_by?(user)
    event_participates.where(user_id: user.id).exists?
  end
  #JpPrefectureによる都道府県登録
  include JpPrefecture
  jp_prefecture :prefucture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  # お知らせ機能
  def create_notification_participate!(current_user)
    # 既に参加になっているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and event_id = ? and action = ? ", current_user.id, user_id, id, 'participate'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        event_id: id,
        visited_id: user_id,
        action: 'participate'
      )
      # 自分のイベントに対する参加の場合は、通知済とする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  # コメントの通知
  def create_notification_event_comment!(current_user, event_comment_id)
    # 自分以外ににコメントしている人を全て取得し、全員に通知を送る
    temp_ids = EventComment.select(:user_id).where(event_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_event_comment!(current_user, event_comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_event_comment!(current_user, event_comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_event_comment!(current_user, event_comment_id, visited_id)
    # コメントは複数回することが考えられるため、一つの投稿に複数回通知する。
    notification = current_user.active_notifications.new(
      event_id: id,
      event_comment_id: event_comment_id,
      visited_id: visited_id,
      action: 'event_comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済とする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
