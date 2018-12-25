Fog.configure do |config|
config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     ENV["ACCESS_KEY_ID"],                       # required
    aws_secret_access_key: ENV["SECRET_ACCESS_KEY"],                        # required
    region:                'eu-west-2',                  # optional, defaults to 'us-east-1'
    host:                  'https://s3.eu-west-2.amazonaws.com',             # optional, defaults to nil
    endpoint:              'https://s3.eu-west-2.amazonaws.com' # optional, defaults to nil
  }
 end

