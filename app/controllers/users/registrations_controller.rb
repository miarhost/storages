class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def edit
    super
    @user.folders = Folder.where(:user_id => @user.id)
    @box_upload = BoxUpload.new
  end
end