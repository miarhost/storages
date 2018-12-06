require 'google/apis/drive_v2'
require 'omniauth-google-oauth2'

class AttachmentUploaderService < ApplicationService

  Drive = Google::Apis::DriveV2
 
  attr_reader :item, :attachment, :folder, :uploaded_file

 def initialize(attachment)
 	@attachment = attachment
 end

 def call
   drive_setup if Rails.env.production?
   item_setup
   file_upload
 end
  
 private 

  def item_setup
    @item.folder_id = @folder.id
    @item.save
    @attachment = @item.find(params[:attachment])
  end

 def drive_setup
  drive = Drive::DriveService.new
  drive = Drive::DriveService.new
  client = Drive::DriveService.new(access_token)
  drive.authorization =  OAuth2::Client.new('x', 'x', :site => 'https://accounts.google.com')
  oauth2_object = OAuth2::AccessToken.new(client, auth.token)
  google_contacts_user = GoogleContactsApi::User.new(oauth2_object)
 end
  # Upload a file
 def file_upload 
  drive = Drive::DriveService.new
  metadata = Drive::File.new(title: 'My document')
  
  file_metadata = {
    name: 'photo.jpg'
  }
 File.open(file_storage_location, 'w') do |f|
  file = drive_service.create_file(file_metadata,
                                 fields: 'id',
                                 upload_source: 'files/photo.jpg',
                                 content_type: 'image/jpeg')
  puts "File Id: #{file.id}"
  file_metadata = {}
  file = drive_service.update_file(id,
                                 file_metadata,
                                 fields: 'id',
                                 upload_source: 'files/photo.jpg',
                                 content_type: 'image/jpeg')
   puts "File Id: #{file.id}"
   f.write uploaded_file.read
  end
 
 end

  def delete_file
    File.delete(file_storage_location)
  end

  def file_storage_location
    File.join(Rails.root, 'public', 'uploads', filename)
  end
  
  def filename
    self.filename = random_prefix + uploaded_file.filename
  end 

  def random_prefix
    Digest::SHA1.hexdigest(Time.now.to_s.split(//).sort_by {rand}.join)
  end
end