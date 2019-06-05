module Api
  module V1
  	 class UsersController < Api::V1::ApplicationController

  	 	before_action :authorize_with_token

  	   def index
  	   	 @users = Folder.joins(:user).group(:user_id)
        render json: @users
  	   end
    end
  end
end 