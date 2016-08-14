FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { "82^%kU3ZdTh7#FVAbW/xJT69rU&pmZHP?.94W>G9^BJHCpb}3z" }
    password_confirmation { "82^%kU3ZdTh7#FVAbW/xJT69rU&pmZHP?.94W>G9^BJHCpb}3z" }
  end
end
