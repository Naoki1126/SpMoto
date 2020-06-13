class HomesController < ApplicationController
  def top
  end

  def new_guest
  	user = User.find_or_create_by!(email: 'guest@guest.com',name: 'guest') do |user|
  		user.password = SecureRandom.urlsafe_base64
  	end

  	sign_in user
  	redirect_to post_images_path, notice: 'ゲストユーザーとしてログインしました'
  end
end
