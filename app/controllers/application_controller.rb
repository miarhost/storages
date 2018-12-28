class ApplicationController < ActionController::Base
 
  before_action :configure_sanitized_parameters, if: :devise_controller? 

  def configure_sanitized_parameters 

    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
   	user_params.permit(:name, :email, :password, :password_confirmation)
    end

    devise_parameter_sanitizer.permit(:sign_in) do |user_params|
  	 user_params.permit(:name, :email, :password, :password_confirmation)
    end

    devise_parameter_sanitizer.permit(:account_update) do |user_params|
  	 user_params.permit(:name, :email, :password, :password_confirmation, :current_password)
    end
  end
  
end
