module Adapter 
  class DropBox

    def initialize
      @client = DropboxClient.new(ENV['ACCESS_TOKEN'])
    end

    def direct_uploads(data)
    	 @client.upload(data)
    end
  end
end

