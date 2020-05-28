class PostImagesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :hashtag, :show, :edit, :create, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @postimagenew = PostImage.new
    @postimagenew.post_image_images.new
  end

  def hashtag
    @user = current_user
    if params[:name].nil?
      @hashtags = Hashtag.all
        
    else
      @hashtag = Hashtag.find_by(hashname: params[:name])
      @postimage = @hashtag.post_images.page(params[:page]).per(25).reverse_order
      @hashtags = Hashtag.all
    end
  end

  def index
    @postimage = PostImage.all.page(params[:page]).per(30).reverse_order
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

    if @postimagenew.save
      redirect_to post_images_path
    else
      render 'post_images/new'
    end
  end

  def update
    @postimage = PostImage.find(params[:id])
    @postimage.user_id = current_user.id
    @postimage.update(update_params)
    redirect_to post_image_path(@postimage)
  end

  def destroy
    @postimage = PostImage.find(params[:id])
    @postimage.destroy
    redirect_to post_images_path
  end

  private

  def post_image_params
    params.require(:post_image).permit(:body, :hashbody, :user_id, post_image_images_images: [], hashtag_ids: [])
  end

  def update_params
    params.require(:post_image).permit(:body, :hashbody, :user_id, hashtag_ids: [])
  end

  def correct_user
    post_image = PostImage.find(params[:id])
    if current_user != post_image.user
      redirect_to root_path
    end
    end
end
