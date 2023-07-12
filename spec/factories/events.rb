FactoryBot.define do
  factory :event do
    title {"pool"}
    description {"a pool party"}
    location {"indore"}
    start_time {"01/12/2011"}
    end_time {"03/12/2011"}
    user
  end
end
