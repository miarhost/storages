module Api
  module V1
  	 class UsersController < Api::V1::ApplicationController

  	   def index
  	   	 @users = User.select("users.*, COUNT(folders.id) as folder_count")
  	   	    .joins("LEFT OUTER JOIN folders ON (folder.user_id = users.id)")
  	   	    .group("users.id")
  	   	 render json: @users
  	   end
    end
  end
end 