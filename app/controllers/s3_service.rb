 module ActiveStorage
  
  class Service::S3Service < Service
    
  attr_reader :client, :bucket, :upload_options

    def initialize(bucket:, upload: {}, **options)
      super
    end

    def url(key)
      instrument :url, key: key do |payload|
        generated_url = object_for(key)
        payload[:url] = generated_url

        generated_url
      end
    end

    def url_for_direct_upload(key)
      instrument :url, key: key do |payload|
        generated_url = object_for(key).presigned_url 
        payload[:url] = generated_url

        generated_url
      end
    end
 end
end