module Api
  module V1
    class BoxUploadsController < Api::V1::ApplicationController
      before_action :authorize_with_token
      
    	 def index
        box_uploads = BoxUpload.where(user_id: current_user.id)
                               .order('created_at DESC') 
                               .paginate(:page => params[:page], :per_page => 40)
        render json: box_uploads
    	 end
    end
  end
end
