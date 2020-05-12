class RelationshipsController < ApplicationController
	
	def create
		@user = User.find(params[:follow_id])
		@following = current_user.follow(@user)
		@following.save

	def destroy
		@user = User.find(params[:follow_id])
		@following = current_user.unfollow(@user)
		@following.destroy
	end

end
end
