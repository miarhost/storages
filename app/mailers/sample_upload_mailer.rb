class SampleUploadMailer < ApplicationMailer

	 default from: "rghostme@gmail.com"
 
  def get_link(email, sample_upload)
  		@email = email
	   @sample_upload = sample_upload
    mail(to: email, subject: "Your upload link on S.F.Uploader is sent by mail")
  end

end
