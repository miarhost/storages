FactoryBot.define do
  factory :sample_upload do
    attachment do
      File.open(File.join(Rails.root, '/spec/fixtures/files/deathclaw.png'))
    end
  end
end
      