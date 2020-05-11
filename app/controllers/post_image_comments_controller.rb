class PostImageCommentsController < ApplicationController

	def create
		@postimage = PostImage.find(params[:post_image_id])
		@comment = current_user.post_image_comments.new(comment_params)
		@comment.post_image_id = @postimage.id
		@comment.save
	end

	def destroy
		@post_image_comment = PostImageComment.find(params[:post_image_id])
		@post_image = @post_image_comment.post_image
		@post_image_comment.destroy
	end

	private
	def comment_params
		params.require(:post_image_comment).permit(:comment,:user_id,:post_image_id)
	end
end
