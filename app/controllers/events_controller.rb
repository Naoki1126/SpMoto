class EventsController < ApplicationController

	def new
		@user = current_user
		@eventnew = Event.new
	end

	def index
		@events = Event.all

		#各ページのlink_to内にパラメータを設置.
		case params[:event_case]
		#今日より未来のイベント情報の表示
   		  when "now"
   		  	#ユーザーIDがパラメータに含まれているか判別
   		  	#含まれていなければ未来の全てのイベント情報。含まれていればユーザー主催の未来のイベントを表示
    		if params[:user_id] == nil
      	   	   @events = Event.where("Date(date_and_time) >= '#{Date.today}'")
      		else 
      	       @events = Event.where(user_id: params[:user_id]).where("Date(date_and_time) >= '#{Date.today}'")
      	    end
      	#今日より過去のイベント情報の表示
    	  when "log"
	  		if params[:user_id] == nil
	  		   @events = Event.where("Date(date_and_time) <= '#{Date.today}'")
	  		else
	  	       @events = Event.where(user_id: params[:user_id]).where("Date(date_and_time) <= '#{Date.today}'")
	  		end
	  	#全てのイベント情報の取得
    	   when ""
     		   @events = Event.all
    	   end
    end

	def show
		@event = Event.find(params[:id])
		@user = @event.user
		@participates = EventParticipate.new
		@comment = EventComment.new
	end

	def edit
		@event = Event.find(params[:id])
		@user = @event.user
	end

	def create
		@eventnew = Event.new(event_params)
		@eventnew.user_id = params[:user_id]
		@eventnew.save
		redirect_to events_path
	end

	def update
		@event = Event.find(params[:id])
		@event.user_id = params[:user_id]
		@event.update(event_params)
		redirect_to events_path
	end

	def destroy_page
		@event = Event.find(params[:event_id])
	end

	def destroy
		@event = Event.find(params[:id])
		@event.destroy
		redirect_to events_path
	end

    private

	def event_params
		params.require(:event).permit(:title,:body,:prefecture_name,:capacity,:date_and_time,:meetingplace,:meetingfinishtime,:user_id)
	end

end
