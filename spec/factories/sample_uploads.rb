FactoryBot.define do
  factory :sample_upload do
    #trait :with_singleupload do
  	file ActionDispatch::Http::UploadedFile.new(:singleupload => "#{Helpers::FilesTestHelper.png}") 
  end
end