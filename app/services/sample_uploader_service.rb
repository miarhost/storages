require 'net/http'
require 'mime/types'
require 'net/http/post/multipart'
class SampleUploaderService < ApplicationService

  HOST = Rails.env.production? ? 'http://storages.herokuapp.com' : 'http://localhost:3000'

  attr_accessor :attachment

  def initialize(attachment) 
    @attachment = attachment
  end
  
  def sample_upload
    @sample_upload ||= SampleUpload.find_by(:attachment)
  end

  def call
  	 upload
  	 to_s3
  end

  private

  def upload
    url = URI.parse("#{HOST}/sample_uploads") 
    File.open("public/image.jpg") do |jpg|
      req = Net::HTTP::Post::Multipart.new(url)
      res = Net::HTTP.start(url.host, url.port) do |http|
      http.request(req)
      end
    end
  end

  def to_s3
  	@data = attachment.tempfile
   s3 = Aws::S3::Resource.new
   bucket = s3.bucket('storagess')
   obj = bucket.object("#{@data}")
  end

end






