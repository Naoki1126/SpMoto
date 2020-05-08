class RelationshipsController < ApplicationController
	
	def create
		user = User.find(params[:follow_id])
		following = current_user.follow(user)
		following.save
		redirect_back(fallback_location: root_path)

	def destroy
		user = User.find(params[:follow_id])
		following = current_user.unfollow(user)
		following.destroy
		redirect_back(fallback_location: root_path)
	end

end
end
