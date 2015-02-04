FactoryGirl.define do
  factory :document, class: 'User::Document' do
    user
    direct_upload_url "https://#{ENV['S3_BUCKET_NAME']}.s3-us-west-2.amazonaws.com/uploads/test/filename.png"
  end
end
