FactoryBot.define do
  factory :user do
    username {"aman"}
    email {Faker::Internet.email }
    password {"123456"} 
  end
end
