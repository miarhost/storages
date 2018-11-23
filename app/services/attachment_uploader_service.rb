require 'google/apis/drive_v2'
require 'omniauth-google-oauth2'

class AttachmentUploaderService < ApplicationService

  Drive = Google::Apis::DriveV2

  attr_accessor :item, :attachment, :folder 

 def initialize(params)
 	@item = params[:item]
  @folder = params[:folder]
 end

 def call
   drive_setup
   item_setup
 end
  
 private 

  def item_setup
    @item.folder_id = @folder.id
    @item.save
    @attachment = @item.find(params[:attachment])
  end

 def drive_setup
  drive = Drive::DriveService.new
  client = Drive::DriveService.new(access_token)
  drive.authorization =  OAuth2::Client.new('x', 'x', :site => 'https://accounts.google.com')
  oauth2_object = OAuth2::AccessToken.new(client, auth.token)
  google_contacts_user = GoogleContactsApi::User.new(oauth2_object)
# Search for files in Drive (first page only)
  files = drive.list_files
  files.items.each do |file|
   puts file.title
  end
  # Upload a file
  @attachment = Drive::File.new(title: 'My document')
  @attachment = drive.insert_file(metadata, upload_source: 'test.txt', content_type: 'text/plain')

# Download a file
 drive.get_file(@attachment, download_dest: '/tmp/myfile.txt')
 end

end
