class StaticPagesController < ApplicationController
 
  def home
 	  @sample_folder = SampleFolder.new
 	  @sample_upload = SampleUpload.new
   	@user = User.new
  end 
   
end
