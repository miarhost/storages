require 'authentication_token'
module Api
  module V1
    class ApplicationController < ActionController::Base

      protect_from_forgery unless: -> { request.format.json? }    

      rescue_from ActionController::ParameterMissing, with: :file_absent
      #before_action :not_authorized

      def current_user
        @current_user ||= super || User.find_by(email: params[:email])
      end

      protected

      def file_absent
        logger.error "Couldn't attach file to a folder"
        redirect_to root_url, notice: 'No files attached'
      end

      def authorize_with_token
        @token = request.headers['Autorization'].split(' ').last
        @auth_token = AuthenticationToken.decode(token)
      end

      def payload(user)
        {
        auth_token: AuthenticationToken.encode({user_id: current_user.id}),
        user: {id: current_user.id, email: current_user.email}
        }
      end

      def not_authorized
        unless payload(user: current_user)
          render json: { message: 'Not authenticated' }, status: 406
        end 
      end
    end
  end
end