require 'aws-sdk-s3'

class SampleUpload < ApplicationRecord

	 include Rails.application.routes.url_helpers

	 belongs_to :sample_folder, optional: true
	 has_one_attached :attachment
	 scope :with_eager_loaded_attachment, -> { eager_load(attachment_attachment: :blob) }

  def new_url
    rails_blob_path(self.attachment, disposition: "attachment", only_path: true)
  end
  

  def geturl
    s3 = Aws::S3::Resource.new
    bucket = s3.bucket('storagess')
    obj = bucket.object("#{attachment}") 
    url = "https://s3.eu-west-2.amazonaws.com/#{bucket}/#{obj.key}"
    url
  end

end

