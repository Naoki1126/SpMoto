class SearchController < ApplicationController
	before_action :authenticate_user!
	def search
		@user = current_user
		if params[:search_case] == "header"

		else
		@model = params["search"]["model"]
		@content = params["search"]["content"]
		@how = params["search"]["how"]
		@datas = search_for(@how,@model,@content)
		end
    end


	private
  # モデルと条件を指定

  #完全一致
 	def match(model,content)
		if model == "会員"
			User.where(name: content)
 		elsif model == "イベント（目的）"
    		Event.where(title: content)
		elsif model == "投稿内容"
      		PostImage.where(body: content)
      	elsif model == 'ハッシュタグ'
      	    Hashtag.find_by(hashname: content)
    	end
 	end

  # 曖昧検索
	def partical(model,content)
		if model == "会員"
			User.where("name LIKE ?", "%#{content}%")
		elsif model == "イベント（目的）"
			Event.where("title LIKE ?", "%#{content}%")
		elsif model == "投稿内容"
			PostImage.where("body LIKE ?", "%#{content}%")
		elsif model == "ハッシュタグ"
			Hashtag.find_by("hashname LIKE ?", "%#{content}%")
		end
	end

	def search_for(how,model,content)
		case how
			when "match"
				match(model, content)
			when "partical"
				partical(model, content)
		end
	end
end
