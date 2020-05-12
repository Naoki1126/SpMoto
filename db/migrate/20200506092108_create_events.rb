class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.text :body
      t.integer :prefecture_code
      t.string :capacity
      t.date :date_and_time
      t.text :meetingplace
      t.date :meetingfinishtime
      t.integer :user_id

      t.timestamps
    end
  end
end
