
require 'net/http'

class SampleUploaderService < ApplicationService

  HOST = Rails.env.production? ? 'http://storages.herokuapp.com' : 'http://localhost:3000'
  BOUNDARY = "XXX"
  
  def initialize(attachment:) 
    @attachment = attachment
  end
  
  def call
  	 upload
  end

  private

  attr_accessor :attachment

  def sample_upload
  	 @sample_upload ||= SampleUpload.find_by(:attachment)
  end

  def upload
    uri = URI.parse("#{HOST}/sample_uploads") 
    file = '/path/to/file'
    mime_type = MIME::Types.type_for(filename)[0] || MIME::Types["application/octet-stream"][0]

    post_body = []
    post_body << "---#{BOUNDARY}\r\n"
    post_body << "Content-Disposition: form-data; name=\"datafile\"; filename=\"#{File.basename(file)}\"\r\n"
    post_body << "Content-Type=#{mime_type}\r\n"
    post_body << "\r\n"
    post_body << File.read(file)
    post_body << "\r\n--#{BOUNDARY}--\r\n"
    Net::HTTP.start(url.host, url.port) do |http|
      request = http.post(uri.request_uri)
      request_body = post_body.join
      request["Content-Type"] =  "multipart/form-data, boundary=#{BOUNDARY}"
      http.request(request)
    end
    

  end

end



