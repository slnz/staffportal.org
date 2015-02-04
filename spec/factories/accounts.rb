FactoryGirl.define do
  factory :account do
    code { Faker::Number.number(3) }
    name { Faker::App.name }
  end
end
