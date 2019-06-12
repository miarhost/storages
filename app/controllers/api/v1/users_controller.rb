module Api
  module V1
  	 class UsersController < Api::V1::ApplicationController

  	 	before_action :authorize_with_token

  	   def index
  	   	 sql = "SELECT * FROM Folders LEFT OUTER JOIN Users ON folders.user_id = Users.id;"
  	   	 @users = ActiveRecord::Base.connection.execute(sql)
  	   	 render json: @users
  	   end
    end
  end
end 