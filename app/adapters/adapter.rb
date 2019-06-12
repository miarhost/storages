require 'net/http'
require "uri"
module Adapter 
  class DropBox
    BOUNDARY = "AaB03x"
  	 TOKEN = ENV['ACCESS_TOKEN']
    attr_reader :file
    
    def initialize(file)
     	@file = file
      @data = file.last
    end

    def direct_uploads
      uri = URI.parse("https://content.dropboxapi.com/2/files/upload")
      post_body = []
      post_body << "--#{BOUNDARY}\r\n"
      post_body << "Authorization: Bearer #{TOKEN} \r\n"
      post_body << "Dropbox-API-Arg: {\"path\": \"#{file}\",\"mode\": \"add\",\"autorename\": true,\"mute\": false,\"strict_conflict\": false}\"\r\n" 
      post_body << "Content-Type: application/octet-stream\r\n"
      post_body << "\r\n"
      post_body << File.read(file)
      post_body << "\r\n--#{BOUNDARY}--\r\n"

      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.request_uri)
      request.body = post_body.join
      request["Content-Type"] = "multipart/form-data, boundary=#{BOUNDARY}"
      http.request(request)
    end
  end
end