class PostImagesController < ApplicationController
	before_action :authenticate_user!, only: [:new,:hashtag,:show,:edit,:create,:update,:destroy]

	def new
		@postimagenew = PostImage.new
		@postimagenew.post_image_images.new
	end

	def hashtag
		@user = current_user
		@hashtag = Hashtag.find_by(hashname: params[:name])
		@postimage = @hashtag.post_images
		@hashtags = Hashtag.all
		@count = @hashtags.count

	end
	def index
		@postimage = PostImageImage.all
		
	end

	def show
		@postimage = PostImage.find(params[:id])
		@user = @postimage.user
		@postimages = @postimage.post_image_images
		@comment = PostImageComment.new
		@favorite = PostImageFavorite.new
		impressionist(@postimage)
	end

	def edit
		@postimage = PostImage.find(params[:id])
		@postimages = @postimage.post_image_images
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
		params.require(:post_image).permit(:body,:hashbody,:user_id,post_image_images_images: [],hashtag_ids: [])
	end

end

