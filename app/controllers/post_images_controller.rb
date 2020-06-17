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
      @hashtags = Hashtag.all.to_a.group_by{ |hashtag| hashtag.post_images.count}
      # hashtags = Hashtag.all
      # @hashtags = []
      # hashtags.each do |hashtag|
      #   temp = {count: hashtag.post_images.count,value: hashtag}
      #   @hashtags.push(temp)
      #   # @hashtags.store(
      #   #   hashtag.post_images.count,
      #   #   hashtag
      #   # )
      # end
      # @hashtags.sort.reverse
    else
      @hashtag = Hashtag.find_by(hashname: params[:name])
      @postimage = @hashtag.post_images.page(params[:page]).per(20).reverse_order
      @hashtags = Hashtag.all.to_a.group_by{ |hashtag| hashtag.post_images.count}
      # @hashtags = {}
      # hashtags.each do |hashtag|
      #   @hashtags.store(
      #     hashtag.post_images.count,
      #     hashtag
      #   )
      # end
      # @hashtags.sort.reverse
    end
  end

  def index
    if params[:user_id] == nil
      @postimage = PostImage.all.page(params[:page]).per(24).reverse_order
    else
      @postimage = PostImage.where(user_id: current_user.followings).page(params[:page]).per(24).reverse_order

    end
  end

  def show
    @postimage = PostImage.find(params[:id])
    @user = @postimage.user
    @postimages = @postimage.post_image_images
    @comment = PostImageComment.new
    @favorite = PostImageFavorite.new
    #閲覧数の取得
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
