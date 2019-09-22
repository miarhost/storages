FactoryBot.define do
  factory :profile do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name}
    dob { "2019-04-15" }
    email { FFaker::Internet.email }
  end
end
