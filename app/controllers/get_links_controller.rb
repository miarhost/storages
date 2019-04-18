class GetLinksController < ApplicationController

		skip_before_action :verify_authenticity_token

  def create
	  @get_link = GetLink.new(get_link_params)
    @sample_upload = SampleUpload.last(params[:sample_folder_id])
      if @get_link.save 
        SampleUploadMailer.get_link(get_link_params[:email], @sample_upload).deliver_later
        redirect_to home_path 
        flash[:notice] = "Check your mail for file upload links"
      else
        flash[:notice] = "Your mail is not valid or connection error, please try again"
        redirect_to sample_folder_sample_upload_path(@sample_folder, @sample_upload)
      end
  end

  def show
    @get_link = GetLink.find(params[:id])
  end

  private

  def get_link_params
  	params.require(:get_link).permit(:email)
  end

end
