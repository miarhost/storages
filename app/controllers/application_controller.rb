class ApplicationController < ActionController::Base
 
  before_action :configure_sanitized_parameters, if: :devise_controller? 

  rescue_from ActionController::ParameterMissing, with: :file_absent

  protected

  def file_absent
    logger.error "Couldn't attach file to a folder"
    redirect_back(fallback_location: root_path, notice: "No files attached.") 
  end
  
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
