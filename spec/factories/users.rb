FactoryBot.define do
  factory :user do
    name { "Extrauser" }
    email { FFaker::Internet.email } 
    password { FFaker::Internet.password } 
  end
end