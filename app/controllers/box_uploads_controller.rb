class BoxUploadsController < ApplicationController     
  include Rails.application.routes.url_helpers
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  
  def new
    @box_upload = BoxUpload.new
  end

  def create 
    @box_upload = BoxUpload.new(box_upload_params)
    box_file = box_upload_params[:box_file] 
    @box_upload.user_id = current_user.id 
    if box_file
      @box_upload.box_file.attach(box_file)
      @box_upload.save
      @box_upload.box_path
    end
    if @box_upload.save
      BoxUploader.new(@box_upload).direct_box
      respond_to do |format| 
        format.html { redirect_to api_v1_box_uploads_url, notice: "File was added to your account"}
        format.json { render :ok, status: :created, location: @box_upload }
      end
    else
      file_absent
    end
  end

  private

  def box_upload_params
    params.require(:box_upload).permit(:box_file)
  end
end