class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy, :destroy_page]

  def index
    @user = current_user
    if params[:prefecture_code].nil?
      @users = User.page(params[:page]).per(50).reverse_order
    else
      @pusers = User.where(prefecture_code: params[:prefecture_code])
      @users = @pusers.page(params[:page]).per(50).reverse_order
      @prefecture = @pusers.find_by(prefecture_code: params[:prefecture_code])
    end
  end

  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images.page(params[:page]).per(25).reverse_order

    # DM機能
    @currententry = Entry.where(user_id: current_user.id)
    @userentry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currententry.each do |ce|
        @userentry.each do |ue|
          if ce.room_id == ue.room_id
            @isroom = true
            @roomid = ce.room_id
          end
        end
      end
      unless @isroom
        @room = Room.new
        @entry = Entry.new
      end
    end
    end

  def edit
    @user = User.find(params[:id])
  end

  def follows
    @user = User.find(params[:user_id])
    @users = @user.followings
  end

  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def destroy_page
    @user = User.find(params[:user_id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:nama, :prefecture_name, :introduction, :profile_image)
   end

  def correct_user
    user = User.find(params[:id])
    if current_user != user
      redirect_to root_path
    end
  end
end
