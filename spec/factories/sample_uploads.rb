FactoryBot.define do
  factory :sample_upload do
    trait :with_singleupload do
  	  singleupload { FilesTestHelpers.png } 
    end
  end
end