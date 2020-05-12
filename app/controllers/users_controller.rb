class UsersController < ApplicationController

	def index
		@user = current_user
		@users = User.page(params[:page]).reverse_order
	end

	def show
		@user = User.find(params[:id])
		@post_image = @user.post_images
		@post_image.each do |post|
		@post =	post.post_image_images
				end
		@post_images = @post_image.page(params[:page]).reverse_order
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
  		params.require(:user).permit(:nama,:prefecture_name, :introduction,:profile_image )

    end

end
