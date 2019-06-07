module Adapter 
  class DropBox

    def initialize
      @client = DropboxClient.new(ENV['ACCESS_TOKEN'])
    end

    def direct_uploads(data)
    	 @client.put_file('/storage/db/#{data}', open('/tmp/db/#{data}'))
    end
  end
end

