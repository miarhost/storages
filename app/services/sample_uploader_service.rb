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
  end

  private

  def upload
    uri = URI.parse("#{HOST}/sample_uploads") 
    file = File.open("public/text.jpg", "r")
    filename = "#{File.basename(file)}"
    header = {"Content-Type": "multipart/form-data; boundary=#{BOUNDARY}"}
    
    post_body = []
    post_body << "--#{BOUNDARY}\r\n"
    post_body << "Content-Disposition: form-data; name=\"datafile\"; filename=\"#{File.basename(file)}\"\r\n"
    post_body << "Content-Type: #{MIME::Types.type_for(file)}\r\n\r\n"
    post_body << "\r\n"
    post_body << File.read(file)
    post_body << "\r\n\r\n--#{BOUNDARY}--\r\n"

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri, header)
    request.body = post_body.join
    
    responce = http.request(request)
  end

end






