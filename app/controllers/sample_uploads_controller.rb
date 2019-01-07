class SampleUploadsController < ApplicationController
  
  skip_before_action :verify_authenticity_token

  def new 
    @sample_upload = SampleUpload.new
  end
  
  def show
    @sample_upload = SampleUpload.find(params[:id])
  end

  def create 
    @sample_upload = SampleUpload.new(sample_upload_params)
    SampleUploaderService.call(params[:attachment])
    unless upload.success?
      puts upload.errors.inspect
    end
    @sample_upload.save
    redirect_to sample_upload_url
    SampleUploadMailer.get_link(sample_upload_params[:email]).deliver_later
  end

  private

  def sample_upload_params
  	 params.require(:sample_upload).permit(:attachment, :email)
  end

end