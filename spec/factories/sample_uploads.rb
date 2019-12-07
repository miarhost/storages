FactoryBot.define do
  factory :sample_upload do
    trait :with_singleupload do
  	  singleupload { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'image.png'), 'image/png') } 
    end
  end
end