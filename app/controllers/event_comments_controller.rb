class EventCommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @event = Event.find(params[:event_id])
    @comment = current_user.event_comments.new(comment_params)
    @comment.event_id = @event.id
    @event.id = @comment.event_id
    @comment.score = Language.get_data(comment_params[:comment])
    @comment.save
    @event.create_notification_event_comment!(current_user, @comment.id)
  end

  def destroy
    @eventcomment = EventComment.find(params[:event_id])
    @eventcomment.event.id = @eventcomment.event_id
    @event = @eventcomment.event
    @eventcomment.destroy
  end

  private

  def comment_params
    params.require(:event_comment).permit(:comment, :user_id, :event_id)
  end
end
