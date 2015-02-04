VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :webmock
  config.ignore_hosts 'codeclimate.com'
  config.default_cassette_options =
    { record: :new_episodes, match_requests_on: [:body] }
  config.configure_rspec_metadata!
end
