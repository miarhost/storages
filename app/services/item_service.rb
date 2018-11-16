require 'google/apis/drive_v2'

module ItemService

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

# Download a file
drive.get_file(metadata.id, download_dest: '/tmp/myfile.txt')

 module Builder 
      def self.call(params)
      attachment = params[:attachment]
      item = Item.find_by(id: item_id)
      Item.new(attachment: attachment)
      end
 end

end