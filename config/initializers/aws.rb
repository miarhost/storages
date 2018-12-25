Aws.config.update({
  region: 'eu-west-2',
  credentials: Aws::Credentials.new(ENV['ACCESS_KEY_ID'], ENV['SECRET_ACCESS_KEY']),
})

BUCKET = Aws::S3::Resource.new.bucket("ENV['BUCKET']")