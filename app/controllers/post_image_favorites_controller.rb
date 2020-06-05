class PostImageFavoritesController < ApplicationController
  before_action :authenticate_user!
  def create
    @postimage = PostImage.find(params[:post_image_id])
    @favorite = current_user.post_image_favorites.new(post_image_id: @postimage.id)
    @favorite.save
    #通知作成
    @postimage.create_notification_favorite!(current_user)
  end

  def destroy
    @postimage = PostImage.find(params[:post_image_id])
    @favorite = PostImageFavorite.find_by(
      user_id: current_user.id,
      post_image_id: @postimage
    )
    @favorite.destroy
  end
end
