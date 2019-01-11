class SampleFoldersController < ApplicationController

  skip_before_action :verify_authenticity_token
 
  
  def new
    @sample_folder = SampleFolder.new
    @sample_upload = SampleUpload.new
  end

  def show 
    @sample_folder = SampleFolder.find(params[:id])
    @sample_upload = SampleUpload.new
    @sample_uploads = SampleUpload.all
  end

  def create 
    @sample_folder = SampleFolder.new(sample_folder_params)
    @sample_folder.save
    redirect_to @sample_folder
  end

  private 

  def sample_folder_params 
    params.permit(:url, :deleted_at)
  end

end


