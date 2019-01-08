class SampleUploadsController < ApplicationController
  
  skip_before_action :verify_authenticity_token
  before_action :set_sample_upload, only: [:show]
  rescue_from ActionController::BadRequest, :with => :bad_request_error

  def index
    @sample_uploads = SampleUpload.all
  end

  def new 
    @sample_upload = SampleUpload.new
  end
  
  def show
    @sample_upload = SampleUpload.find(params[:id])
  end

  def create 
    @sample_upload = SampleUpload.new(sample_upload_params)
    SampleUploaderService.call(sample_upload_params[:attachment])
    if @sample_upload.save
      redirect_to sample_upload_path(@sample_upload)
      SampleUploadMailer.get_link(sample_upload_params[:email]).deliver_later
    else
      flash[:notice] = "Add a file to upload"
      redirect_to root_url
    end
  end

  private

  def sample_upload_params
  	 params.require(:sample_upload).permit(:attachment, :email, :id)
  end
  
  def set_sample_upload
    @sample_upload = SampleUpload.find(params[:id])
  end

end