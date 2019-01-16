class SampleUploadsController < ApplicationController
  
  skip_before_action :verify_authenticity_token
  before_action :set_sample_folder

    rescue_from ActionController::ParameterMissing do |exception|     
    redirect_to home_path 
    flash[:notice] = "Add a file to upload!"
    end
 
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
    @sample_upload = @sample_folder.sample_uploads.build(sample_upload_params)
      if @sample_upload.save
        flash[:success] = "File added to your folder"
        redirect_to sample_folder_path(@sample_folder)
      else
        flash[:notice] = "File can't be saved"
        redirect_to home_path
      end
  end

  def download 
    @sample_upload.attachment.download
  end
  
  def destroy
    @sample_upload = SampleUpload.find(params[:id])
    @sample_upload.destroy
    respond_to do |format|
      format.html { redirect_to sample_folder_path(@sample_folder), notice: 'File is deleted!' }
      format.json { head :no_content }
    end
  end

  private

  def sample_upload_params
  	params.require(:sample_upload).permit(:attachment, :email, :id, :sample_folder_id)
  end
  
  def set_sample_folder
    @sample_folder = SampleFolder.find(params[:sample_folder_id])
  end

end