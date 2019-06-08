require 'dropbox_sdk'
module Adapter 
  class DropBox

    def initialize
      @client = DropboxClient.new(ENV['ACCESS_TOKEN'])
    end

    def direct_uploads(data)
    	 puts "linked account:", @client.account_info().inspect
    	 @client.put_file('/storage/#{data}', open('/storage/#{data}'))
    end
  end
end

