class StaticPagesController < ApplicationController
 
 def home
 	@sample_upload = SampleUpload.new
 end 
   
end
