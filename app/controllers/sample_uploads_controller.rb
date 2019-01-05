class SampleUploadsController < ApplicationController
  
  skip_before_action: verify_authenticity_token

  def new 
    @sample_upload = SampleUpload.new(sample_upload_params)
  end
  
  def show
    @sample_upload = SampleUpload.find(params[:id])
  end

  def create 
    @sample_upload = SampleUpload.new(sample_upload_params)
    @sample_upload.save
    redirect_to sample_ipload_url
    SampleUploadMailer.get_link(sample_upload_params[:email]).deliver_later
  end

  private

  def item_params
  	 params.require(:sample_upload).permit(:attachment, :email)
  end

end