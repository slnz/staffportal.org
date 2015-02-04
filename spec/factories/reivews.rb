FactoryGirl.define do
  factory :review do
    open Date.today
    due(Date.today + 10.days)
  end
end
