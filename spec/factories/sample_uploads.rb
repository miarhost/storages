FactoryBot.define do
  factory :sample_upload do
  	 association :sample_folder, factory: :sample_folder
    trait :with_singleupload do
      singleupload { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'deathclaw.png'), 'image/png') }
    end
  end
end
 