class ChangeColumnToEvent < ActiveRecord::Migration[5.2]
  def up
    change_column :events, :date_and_time, :datetime
    change_column :events, :meetingfinishtime, :datetime
  end

  def down
    change_column :events, :date_and_time, :date
    change_column :events, :meetingfinishtime, :date
  end
end
