class AdminsController < ApplicationController
  
  before_action :authenticate_admin!

  def index
  	 @total_views = Item.views.count
  	 @users = User.all
  end
end

