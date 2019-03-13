class GetLinksController < ApplicationController

		skip_before_action :verify_authenticity_token

  def create
	  @get_link = GetLink.new(get_link_params)
      if @get_link.save 
        flash[:success] = "Check your mail for file upload links"
        SampleUploadMailer.get_link(get_link_params[:email]).deliver_later
        redirect_to home_path 
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
