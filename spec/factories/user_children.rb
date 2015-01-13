# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_child, :class => 'User::Child' do
    first_name "MyString"
    last_name "MyString"
    dietary_requirements "MyText"
    medical_requirements "MyText"
    media_waiver false
    comments "MyText"
    swimming_capability 1
    outings false
    activity_limitations "MyText"
    toileting_assistance "MyText"
    date_of_birth "2015-01-13"
  end
end
