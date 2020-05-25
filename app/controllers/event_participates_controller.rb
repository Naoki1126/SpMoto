class EventParticipatesController < ApplicationController
  before_action :authenticate_user!
  def index
    @event = Event.find(params[:event_id])
    @participate = EventParticipate.where(event_id: @event.id)
  end

  def create
    @event = Event.find(params[:event_id])
    @participate = current_user.event_participates.new(event_id: @event.id)
    @participate.save
    @event.create_notification_participate!(current_user)
  end

  def destroy
    @event = Event.find(params[:event_id])
    @participate = EventParticipate.find_by(
      user_id: current_user.id,
      event_id: @event
    )
    @participate.destroy
  end
end
