FactoryBot.define do
  factory :user do
    username {"palash"}
    email {Faker::Internet.email }
    password {"123456"} 
  end
end
