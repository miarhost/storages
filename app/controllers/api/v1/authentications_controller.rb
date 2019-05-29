module Api
  module V1
    class AuthenticationsController < Api::V1::ApplicationController

      def authorize
        begin
      	  user ||= User.find_by(email: params[:email])
        rescue ActiveRecord::RecordNotFound
        end
      	if user && user.valid_password?(params[:password])
         	render json: authorized(user), status: 200
        else 
          render json: { message: 'Not authenticated' }, status: 406
      	end
      end

      private

      def authorized(user)
        user ||= User.find_by(email: params[:email])
        begin
      	{
      	 	token:  AuthenticationToken.encode({id: user.id}),
      	 	user: {id: user.id, email: user.email}
      	}
      	rescue 
      		nil
      	end
      end
    end
  end
end