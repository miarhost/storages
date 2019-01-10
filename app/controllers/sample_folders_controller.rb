class SampleFolder < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :set_sample_folder, only: [:show, :update, :edit, :destroy]
  
  def new
    @sample_folder = SampleFolder.new
  end

  def show 
    @sample_folder = SampleFolder.find(params[:id])
    @sample_uploads = SampleUpload.all
  end

  def create 
    @sample_folder = SampleFolder.new(sample_folder_params)
    @sample_folder.save
    redirect_to @sample_folder
  end

  private 

  def sample_folder_params 
    params.require(:sample_folder).permit(:url, :deleted_at)
  end




