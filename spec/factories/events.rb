FactoryGirl.define do
  factory :event do
    name { Faker::App.name }
    description { Faker::Lorem.sentence }
    start_date { Faker::Time.between(Time.now, 3.days.from_now) }
    finish_date { Faker::Time.between(10.days.from_now, 20.days.from_now) }
    adult_cost { Faker::Number.number(2) }
    teen_cost { Faker::Number.number(2) }
    child_cost { Faker::Number.number(2) }
    association :logo, factory: :document
  end
end
