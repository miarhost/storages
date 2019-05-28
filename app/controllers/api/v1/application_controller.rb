require 'authentication_token'
module Api
  module V1
    class ApplicationController < ActionController::Base

      protect_from_forgery unless: -> { request.format.json? }  
      rescue_from ActionController::ParameterMissing, with: :file_absent
      attr_accessor :user
      
      protected

      def file_absent
        logger.error "Couldn't attach file to a folder"
        redirect_to root_url, notice: 'No files attached'
      end

      def authorize_with_token
        user ||= User.find_by(email: params[:email])
        Rails.logger.info(user).inspect
        if user && user.authenticate!(password: params[:password])
          render json: auth_token
        else
          render json: { message: 'Not authenticated' }, status: 406
        end
        @token = request.headers['Autorization'].split(' ').last
        @auth_token = AuthenticationToken.decode(token)
      end
      

      def auth_token(token)
        token = @token
        @auth_token ||= AuthenticationToken.decode(token)
      end

      def payload(user)
        {
        token: AuthenticationToken.encode({user_id: user.id}),
        user: {id: user.id, email: user.email}
        }
      end
    end
  end
end