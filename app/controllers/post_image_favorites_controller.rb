class PostImageFavoritesController < ApplicationController

	def create
		@postimage = PostImage.find(params[:post_image_id])
		@favorite = current_user.post_image_favorites.new(post_image_id: @postimage.id)
		@favorite.save
		post_image.create_notification_favorite!(current_user)
	end

	def destroy
		@postimage = PostImage.find(params[:post_image_id])
		@favorite = PostImageFavorite.find_by(
			user_id: current_user.id,
			post_image_id: @postimage)
		@favorite.destroy
	end
end
