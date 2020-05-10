class PostImagesController < ApplicationController

	def new
		@postimagenew = PostImage.new
		@postimagenew.post_image_images.new
	end

	def hashtag
		@user = current_user
		@tag = Hashtag.find_by(hashname: params[:name])
		@postimagenew = @tag.post_images.new

	end
	def index
		@postimage = PostImage.all
		@postimage.each do |post|
			@post = post.post_image_images
		end
	end

	def show
		@postimage = PostImage.find(params[:id])
		@user = @postimage.user
		@postimages = @postimage.post_image_images


	end

	def edit
	end

	def create
		@postimagenew = PostImage.new(post_image_params)
		@postimagenew.user_id = current_user.id
		@postimagenew.save!
		redirect_to post_images_path
	end

	def update
	end

	def destroy
	end

	private
	def post_image_params
		params.require(:post_image).permit(:body,:user_id,post_image_images_images: [],hashtag_ids: [])
	end

end

