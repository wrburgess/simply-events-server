FactoryGirl.define do
  factory :event do
    name { Faker::Company.catch_phrase }
    description { Faker::Lorem.sentences(1)[0] }
  end
end
