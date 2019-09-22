FactoryBot.define do
  factory :sample_upload do
    trait :with_singleupload do
      singleupload { FilesTestHelper.png }
    end
  end
end
 