module Api
  module V1
    class AuthenticationsController < Api::V1::ApplicationController

      def authorize
        Rails.logger.info(request.headers)
        begin
      	  current_user
        rescue ActiveRecord::RecordNotUnique
        end
      	if @current_user.valid_password?(password: params[:password])
      	 	render json: authorized(user), status: 200
        else 
          render json: not_authorized, status: 406
      	end
      end

      def auth_token(token)
        token = @token
        @auth_token ||= AuthenticationToken.decode(token)
      end

      def authorized(user)
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