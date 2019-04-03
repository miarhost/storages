FactoryBot.define do
  factory :get_link do
    email { FFaker::Internet.safe_email }
  end
end