require 'net/http'
require "uri"
require 'json'
module Adapter 
  class DropBox
    BOUNDARY = "AaB03x"
  	 TOKEN = ENV['ACCESS_TOKEN']
  	 CLIENT_TOKEN = ENV['CLIENT_TOKEN']
    attr_reader :file, :data
    
    def initialize(file, data)
     	@file = file
      @data = data
    end

    def direct_uploads
      uri = URI.parse("https://content.dropboxapi.com/2/files/upload")
      post_body = []
      post_body << "--#{BOUNDARY}\r\n"
      post_body << "Authorization: Bearer #{CLIENT_TOKEN} \r\n"
      post_body << "Dropbox-API-Arg: JSON.parse({\"path\": \"#{file}\",\"mode\": \"add\",\"autorename\": true,\"mute\": false,\"strict_conflict\": false})\"\r\n" 
      post_body << "Content-Type: application/octet-stream\r\n"
      post_body << "\r\n"
      post_body << "data-binary: #{File.read(file)}"
      post_body << "\r\n--#{BOUNDARY}--\r\n"

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.path, {'Content-Type' =>'application/octet-stream',  
          'Authorization' => 'Bearer #{CLIENT_TOKEN}', 'Dropbox-API-Arg' => 'JSON.parse({\"path\": \"#{file}\",\"mode\": \"add\",\"autorename\": true,\"mute\": false,\"strict_conflict\": false})'})
      request.body = post_body.join
      resp = http.request(request)
      resp.to_json
      Rails.logger.info(resp.body).inspect
      Rails.logger.info(file).inspect
      Rails.logger.info(data).inspect
    end
  end
end
