class CreatePostImages < ActiveRecord::Migration[5.2]
  def change
    create_table :post_images do |t|
      t.text :body
      t.string :user_id

      t.timestamps
    end
  end
end
