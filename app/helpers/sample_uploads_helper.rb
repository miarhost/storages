  module SampleUploadsHelper

  def geturl(attachment)
    @sample_upload = SampleUpload.new
    attachment = @sample_upload.attachment
    s3 = Aws::S3::Resource.new
    bucket = s3.bucket('storagess')
    obj = bucket.object("#{attachment}")
    attachment.url = "https://s3.eu-west-2.amazonaws.com/storagess/#{obj.key}"
  end

end