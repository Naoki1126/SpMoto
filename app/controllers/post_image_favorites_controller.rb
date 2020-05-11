class PostImageFavoritesController < ApplicationController

	def create
		@postimage = PostImage.find(params[:post_image_id])
		@favorite = current_user.favorites.new(post_image_id: @postimage.id)
		@favorite.save
	end

	def destroy
		@postimage = PostImage.find(params[:post_image_id])
		@favorite = Favorite.find_by(
			user_id: current_user.id,
			post_image_id: params[:post_image_id]
		@favorite.destroy
	end
end
