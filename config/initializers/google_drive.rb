  drive = Drive::DriveService.new
  client = Drive::DriveService.new(access_token)
  drive.authorization =  OAuth2::Client.new('x', 'x', :site => 'https://accounts.google.com')
  oauth2_object = OAuth2::AccessToken.new(client, auth.token)
  google_contacts_user = GoogleContactsApi::User.new(oauth2_object)