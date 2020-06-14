class EventParticipate < ApplicationRecord
  belongs_to :user
  belongs_to :event

  #gem simple_calender用
  def start_time
    event.date_and_time
  end

  def end_time
    event.meetingfinishtime
  end

end
