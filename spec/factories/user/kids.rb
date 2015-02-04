FactoryGirl.define do
  factory :kid, class: 'User::Kid' do
    first_name 'MyString'
    last_name 'MyString'
    dietary_requirements 'MyText'
    medical_requirements 'MyText'
    media_waiver true
    comments 'MyText'
    swimming_capability 1
    outings false
    activity_limitations 'MyText'
    toileting_assistance 'MyText'
    date_of_birth '2015-01-13'
  end
end
