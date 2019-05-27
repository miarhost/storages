module Api
  module V1
  	 class UsersController < Api::V1::ApplicationController

  	   def index
  	   	 @users = Folder.joins(:user).group(:user_id).count(:user_id)
        render json: @users
  	   end
    end
  end
end 