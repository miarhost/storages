module Api
  module V1
    class ApplicationController < ActionController::Base
      
      protect_from_forgery with :null_session

      rescue_from ActionController::ParameterMissing, with: :file_absent

      protected

      def file_absent
        logger.error "Couldn't attach file to a folder"
        redirect_to root_url, notice: 'No files attached'
      end
  end
end