class PostImageCommentsController < ApplicationController
before_action :authenticate_user!
	def create
		@postimage = PostImage.find(params[:post_image_id])
		@comment = current_user.post_image_comments.new(comment_params)
		@comment.post_image_id = @postimage.id
		@postimage.id = @comment.post_image_id
		@comment.save
		@postimage.create_notification_post_image_comment!(current_user, @comment.id)
	end

	def destroy
		@postimagecomment = PostImageComment.find(params[:post_image_id])
		@postimagecomment.post_image.id = @postimagecomment.post_image_id
		@postimage = @postimagecomment.post_image
		@postimagecomment.destroy
	end

	private
	def comment_params
		params.require(:post_image_comment).permit(:comment,:user_id,:post_image_id)
	end
end
