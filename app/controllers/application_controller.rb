class ApplicationController < ActionController::Base
		before_action :configure_permitted_parameters, if: :devise_controller?	

	protected
	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :first_name_kana, :last_name_kana, :email, :postcode, :address, :phone_number ])
	end

	def after_sign_in_path_for(resource)
	end

	def after_sign_out_path_for(resource)
	end

end
