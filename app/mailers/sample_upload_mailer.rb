class SampleUploadMailer < ApplicationMailer

	 default from: "rghostme@gmail.com"
 
 #change url for another source method
	 def get_link(email_address)
	   @email_address = email_address
	   mail(to: email_address, subject: "Your upload link on S.F.Uploader: #{url_for(@sample_upload)}")
  end 

end
