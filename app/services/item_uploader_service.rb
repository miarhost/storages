require 'google/apis/drive_v2'

class ItemUploaderService
 
 def initialize(params)
 	@item = params[:item]
 	end

 def perform 
   upload_attachment
 end
  
 private 

 def upload_attachment
 	drive_setup
 end

 def drive_setup
  Drive = Google::Apis::DriveV2 # Alias the module
  drive = Drive::DriveService.new
  drive.authorization =  OAuth2::Client.new('x', 'x', :site => 'https://accounts.google.com')
  oauth2_object = OAuth2::AccessToken.new(client, auth.token)
  google_contacts_user = GoogleContactsApi::User.new(oauth2_object)
# Search for files in Drive (first page only)
  files = drive.list_files
  files.items.each do |file|
   puts file.title
  end
  # Upload a file
 metadata = Drive::File.new(title: 'My document')
 metadata = drive.insert_file(metadata, upload_source: 'test.txt', content_type: 'text/plain')
 @item.attachment = metadata
# Download a file
 drive.get_file(metadata.id, download_dest: '/tmp/myfile.txt')
 end

end