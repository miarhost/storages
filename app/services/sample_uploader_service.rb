require 'net/http'
require 'mime/types'

class SampleUploaderService < ApplicationService

  HOST = Rails.env.production? ? 'http://storages.herokuapp.com' : 'http://localhost:3000'
  BOUNDARY = "XXX"

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
    uri = URI.parse("#{HOST}/sample_uploads") 
    file = File.open("public/test.jpg", "r")
    filename = "#{File.basename(file)}"
    
    
    post_body = []
    post_body << "--#{BOUNDARY}\r\n"
    post_body << "Content-Disposition: attachment; name=\"datafile\"; filename=\"#{File.basename(file)}\"\r\n"
    post_body << "Content-Type: application/octet-stream\r\n"
    post_body << "\r\n"
    post_body << File.read(file)
    post_body << "\r\n\r\n--#{BOUNDARY}--\r\n"

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri)
    request.body = post_body.join
    
    response = http.request(request)
    response.body
  end

  def to_s3
  	@data = attachment.tempfile
   s3 = Aws::S3::Resource.new
   bucket = s3.bucket('storagess')
   obj = bucket.object('#{@data}')
  
  end

end






