module Api
  module V1
  	 class UsersController < Api::V1::ApplicationController

  	   def index
  	   	 render json: @users
  	   end
    end
  end
end 