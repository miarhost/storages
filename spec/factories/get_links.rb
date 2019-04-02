FactoryBot.define do
  factory :get_link, class: 'GetLink' do
    email { FFaker::Internet.safe_email }
  end
end