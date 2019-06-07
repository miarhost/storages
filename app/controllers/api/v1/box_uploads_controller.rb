module Api
  module V1
    class BoxUploadsController < Api::V1::ApplicationController

    	 def index
        box_uploads = BoxUpload.where(user_id: params[:user_id])
                               .order('created_at: DESC') 
                               .paginate(:page => params[:page], :per_page => 40)
        render json: box_uploads
    	 end    	 	
    end
  end
end
