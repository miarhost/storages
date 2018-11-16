require 'net/http/post/multipart'

class Item < ApplicationRecord
 
 belongs_to :folder
 

 def item_params
  require_params = params.require(:item).permit(:attachment)
  require_params[:attachment = item_params[:attachment].present? ? UploadIO.new(item_params[:attachment].tempfile, item_params[:attachment].content_type, iteml_params[:attachment].original_filename) : nil
  require_params
 end

 url = URI.parse('http://www.example.com/upload')
 Net::HTTP.start(url.host, url.port) do |http|
  req = Net::HTTP::Post::Multipart.new(url, item_params)
  key = "authorization_key"
  req.add_field("Authorization", key) #add to Headers
  http.use_ssl = (url.scheme == "https")
  http.request(req)
 end


end
