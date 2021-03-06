if ENV['CODECLIMATE_REPO_TOKEN']
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
else
  require 'simplecov'
  SimpleCov.start 'rails'
end

ENV['RAILS_ENV'] = 'test'

require File.expand_path('../../config/environment', __FILE__)

require 'rspec/rails'
require 'shoulda/matchers'
require 'draper/test/rspec_integration'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |file| require file }

Rails.logger.level = 4

module Features
  include Formulaic::Dsl
end

RSpec.configure do |config|
  config.extend VCR::RSpec::Macros
  config.include Features, type: :feature
  config.include Requests::ApiHelpers, type: :request
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = false
end

ActiveRecord::Base.observers.disable :all
ActiveRecord::Migration.maintain_test_schema!
Capybara.javascript_driver = :webkit
