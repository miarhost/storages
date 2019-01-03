class UsersController < ApplicationController

  def index
    @users = User.paginate(:page => params[:page], :per_page => 40)
  end

  def show
    @user = User.find(params[:id])
    @folders = Folder.where(:user_id => @user.id)
  end

end
