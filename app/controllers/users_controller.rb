class UsersController < ApplicationController

  def index
    @users = User.paginate(:page => params[:page], :per_page => 10)
  end

 def show
  @user = User.find(params[:id])
  #Later move to another specific action: 
 redirect_to users_url(@users), :status => 418, :alert => "No such user"
 end

end
