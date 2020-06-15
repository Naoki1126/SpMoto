class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :prefecture_code])
  end

  def after_sign_in_path_for(resource)
    post_images_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def check_guest_destroy
    @user = current_user
    if @user.email == 'guest@guest.com'
      redirect_to root_path, alert: 'ゲストユーザーに権限がありません'
    end
  end

  def check_guest_edit
    if params[:user][:email].downcase == 'guest@guest.com'
      redirect_to root_path, alert: 'ゲストユーザーの変更・削除はできません。'
    end
  end
end
