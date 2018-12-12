require 'google/apis/drive_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'
require 'omniauth-google-oauth2'
require 'google/api_client/client_secrets'


class AttachmentUploaderService < ApplicationService

OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'.freeze
APPLICATION_NAME = 'storages'.freeze
CREDENTIALS_PATH = 'config/credentials.json'
TOKEN_PATH = 'token.yaml'.freeze
SCOPE = Google::Apis::DriveV3::AUTH_DRIVE_METADATA_READONLY

  attr_reader :attachment, :service

 def initialize(attachment)
 	@attachment = attachment
 end
 
 def call
   authorize
   file_upload
 end
  
 private 

 def authorize
  client_id = Google::Auth::ClientId.from_file(CREDENTIALS_PATH)
  token_store = Google::Auth::Stores::FileTokenStore.new(file: TOKEN_PATH)
  authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
  user_id = 'default'
  credentials = authorizer.get_credentials(user_id)
  if credentials.nil?
    url = authorizer.get_authorization_url(base_url: OOB_URI)
    puts 'Open the following URL in the browser and enter the ' \
         "resulting code after authorization:\n" + url
    code = gets
    credentials = authorizer.get_and_store_credentials_from_code(
      user_id: user_id, code: code, base_url: OOB_URI
    )
  end
  credentials
end

 def file_upload
 service = Google::Apis::DriveV3::DriveService.new
 service.client_options.application_name = APPLICATION_NAME
 service.authorization = authorize
 if service.authorization.nil?
    client_secrets = Google::APIClient::ClientSecrets.load
 end
  metadata = Google::Apis::DriveV3::File.new(title: 'My document')

  file_metadata = {
    name: 'photo.jpg'
  }
location = RestClient.post("https://www.googleapis.com/upload/drive/v3/files/#{file_id}?alt=media")
 metadata.open(location, 'w') do |f|
  file = service.create_file(file_metadata,
                                 fields: 'id',
                                 upload_source: 'files/photo.jpg',
                                 content_type: 'image/jpeg')
  puts "File Id: #{file.id}"
  file_metadata = {}
  file = service.update_file(id,
                                 file_metadata,
                                 fields: 'id',
                                 upload_source: 'files/photo.jpg',
                                 content_type: 'image/jpeg')
   puts "File Id: #{file.id}"
   f.write uploaded_file.read
  end


 response = service.list_files(page_size: 10,
                              fields: 'nextPageToken, files(id, name)')
 puts 'Files:'
 puts 'No files found' if response.files.empty?
 response.files.each do |file|
  puts "#{file.name} (#{file.id})"
 end
end
end
