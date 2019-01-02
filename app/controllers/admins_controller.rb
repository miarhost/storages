class AdminsController < ApplicationController
  
  before_action :authenticate_admin!

  def index
  	 @users = User.paginate(:page => params[:page], :per_page => 40)
  end
end

