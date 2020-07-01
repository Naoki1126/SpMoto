class PostImage < ApplicationRecord
  validates :body, length: { in: 1..1000 }
  validates :post_image_images, presence: true
  #下記２行複数画像の保存に必要な記載
  has_many :post_image_images, dependent: :destroy
  accepts_attachments_for :post_image_images, attachment: :image
  #ハッシュタグ
  has_many :hashtag_post_images, dependent: :destroy
  has_many :hashtags, through: :hashtag_post_images
  belongs_to :user
  has_many :post_image_comments, dependent: :destroy
  has_many :post_image_favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy
  # いいね機能実装ののために必要
  def post_image_favorited_by?(user)
    post_image_favorites.where(user_id: user.id).exists?
  end
  # PV数表示のための表記
  is_impressionable

  # お知らせ機能
  def create_notification_favorite!(current_user)
    # 既にいいねされているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_image_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_image_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      # 自分の投稿に対するいいねの場合は、通知済とする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  # コメントの通知
  def create_notification_post_image_comment!(current_user, post_image_comment_id)
    # 自分以外にコメントしている人を全て取得し、全員に通知を送る
    temp_ids = PostImageComment.select(:user_id).where(post_image_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_post_image_comment!(current_user, post_image_comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_post_image_comment!(current_user, post_image_comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_post_image_comment!(current_user, post_image_comment_id, visited_id)
    # コメントは複数回することが考えられるため、一つの投稿に複数回通知する。
    notification = current_user.active_notifications.new(
      post_image_id: id,
      post_image_comment_id: post_image_comment_id,
      visited_id: visited_id,
      action: 'post_image_comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済とする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  # ハッシュタグ機能
  # 作成アクション
  after_create do
    post_image = PostImage.find_by(id: id)
    # hashbodyに打ち込まれたハッシュタグを検出
    hashtags = hashbody.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      # ハッシュタグは先頭の#を外した上で保存
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      post_image.hashtags << tag
    end
  end
  #更新アクション
  before_update do
    post_image = PostImage.find_by(id: id)
    post_image.hashtags.clear
    hashtags = hashbody.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      post_image.hashtags << tag
    end
  end
end
