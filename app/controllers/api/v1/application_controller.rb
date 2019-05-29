require 'authentication_token'
module Api
  module V1
    class ApplicationController < ActionController::Base

      protect_from_forgery unless: -> { request.format.json? }  
      rescue_from ActionController::ParameterMissing, with: :file_absent

      protected

      def authorize_with_token
        begin
          user ||= User.find_by(@auth_token[:user_id])
        rescue JWT::DecodeError
        end
        if user
          render json: { message: 'Authorized'}, status: 200
        else
          render json: { message: 'Not authenticated' }, status: 418
        end
      end

      def file_absent
        logger.error "Couldn't attach file to a folder"
        redirect_to root_url, notice: 'No files attached'
      end

      private

      def payload
        head = request.headers['Authorization'].split(' ').last if request.headers['Authorization'].present?
        @token = AuthenticationToken.encode(head)
      end

      def auth_token
        @auth_token = AuthenticationToken.decode(@token)
      end
    end
  end
end