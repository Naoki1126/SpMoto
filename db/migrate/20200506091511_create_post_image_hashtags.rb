class CreatePostImageHashtags < ActiveRecord::Migration[5.2]
  def change
    create_table :post_image_hashtags do |t|
      t.references :post_image_id, index: true, foreign_key: true
      t.references :hashtag_id, index: true, foreign_key: true

      t.timestamps
    end
  end
end
