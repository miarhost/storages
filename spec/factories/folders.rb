FactoryBot.define do
  factory :folder do
    title { "MyTitle" }
    description { "MyDescription" }
    user
    filenum { 0 }
  end
end  
    
