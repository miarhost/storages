require 'authentication_token'
module Api
  module V1
    class ApplicationController < ActionController::Base

      protect_from_forgery unless: -> { request.format.json? }  
      attr_reader :user

      protected

      def authorize
        begin
          @user ||= User.find_by(email: params[:email])
        rescue ActiveRecord::RecordNotFound
        end
        if @user && @user.valid_password?(params[:password])
          render json: authorized(@user), status: 200
          @token = AuthenticationToken.encode(@payload)
        else 
          render json: { message: 'Not authenticated' }, status: 406
        end
      end

      def authorize_with_token
        if request.headers['x-user-id'] == user
          return
        else
          render json: { message: 'Not authenticated' }, status: 406
        end
      end

      private

      def authorized!(user)
        begin
          @payload = 
        {
          token:  AuthenticationToken.encode({id: @user.id}),
          user: {id: @user.id, email: @user.email}
        }
        rescue 
          nil
        end
      end

      def auth_token
        auth_token = AuthenticationToken.decode(@token)
        Rails.logger.info(@auth_token).inspect
        auth_token
      end
    end
  end
end