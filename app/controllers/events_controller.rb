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
      	   	   @events = Event.where("Date(date_and_time) <= '#{Date.today}'")
      		else 
      	       @events = Event.where(user_id: params[:user_id]).where("Date(date_and_time) <= '#{Date.today}'")
      	    end
      	#今日より過去のイベント情報の表示
    	  when "log"
	  		if params[:user_id] == nil
	  		   @events = Event.where("Date(date_and_time) >= '#{Date.today}'")
	  		else
	  	       @events = Event.where(user_id: params[:user_id]).where("Date(date_and_time) >= '#{Date.today}'")
	  		end
	  	#全てのイベント情報の取得
    	   when ""
     		   @events = Event.all
    	   end
    end

	def show
	end

	def edit
	end

	def create
	end

	def update
	end

	def destroy
	end
end

private

	def event_params
		params.require(:event).permit(:title,:body,:prefecture_code,:capacity,:date_and_time,:meetingplace,:meetingtime,:user_id)
	end

end
