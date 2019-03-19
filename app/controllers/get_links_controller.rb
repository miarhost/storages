class GetLinksController < ApplicationController

		skip_before_action :verify_authenticity_token

  def create
	  @get_link = GetLink.new(get_link_params)
    @sample_upload = SampleUpload.last(params[:sample_folder_id])
      if @get_link.save 
        flash[:success] = "Check your mail for file upload links"
        SampleUploadMailer.get_link(get_link_params[:email], @sample_upload).deliver_later
        redirect_to home_path 
      end
  end

  private

  def get_link_params
  	params.require(:get_link).permit(:email)
  end

end
