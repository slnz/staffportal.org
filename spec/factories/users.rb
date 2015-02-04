FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    factory :full_user do
      first_name { Faker::Name.first_name }
      last_name { Faker::Name.last_name }
    end
  end
end
