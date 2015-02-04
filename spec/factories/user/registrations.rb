FactoryGirl.define do
  factory :registration, class: 'User::Registration' do
    user
    event
    comments { Faker::Lorem.sentence }
  end
end
