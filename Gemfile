source 'https://rubygems.org'
# Rails
gem 'rails', '4.1.13'
gem 'rails-observers'

# Postgres
gem 'pg'

# Authentication & Authorization
gem 'devise'
gem 'devise_cas_authenticatable'
gem 'symmetric-encryption'
gem 'cancancan'
gem 'role_model'

# Queue
gem 'redis'
gem 'resque'
gem 'resque-retry'
gem 'resque-status'
gem 'hirefire-resource'

# API
gem 'feedjira'
gem 'gravatarify'
gem 'httparty'
gem 'httparty-cookies'

# Controller
gem 'inherited_resources'
gem 'paperclip'
gem 'aws-sdk'
gem 's3_direct_upload'
gem 'fiscali'
gem 'kaminari'
gem 'ransack'
gem 'has_scope'
gem 'draper'

# View
gem 'breadcrumbs_on_rails'
gem 'formtastic'
gem 'formtastic-bootstrap'
gem 'kaminari-bootstrap'
gem 'haml'
gem 'table_for_collection'
gem 'high_voltage'

# Model
gem 'phony_rails'
gem 'currency_select', github: 'tanordheim/currency_select'
gem 'active_type'
gem 'merit'

# Javascript
gem 'highcharts-rails'
gem 'summernote-rails'
gem 'chosen-rails'
gem 'cocoon'

# Administration
gem 'activeadmin', github: 'gregbell/active_admin'
gem 'groupdate'
gem 'chartkick'

gem 'sass-rails'
gem 'bootstrap-sass'
gem 'uglifier'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'gmaps-autocomplete-rails'
gem 'turbolinks'
gem 'jquery-turbolinks'
gem 'nprogress-rails'
gem 'font-awesome-rails'

group :test do
  gem 'capybara-webkit'
  gem 'database_cleaner'
  gem 'formulaic'
  gem 'launchy'
  gem 'shoulda-matchers', require: false
  gem 'codeclimate-test-reporter', require: nil
  gem 'simplecov'
  gem 'timecop'
  gem 'webmock'
  gem 'vcr'
  gem 'faker'
end

group :development, :test do
  gem 'awesome_print'
  gem 'byebug'
  gem 'dotenv-rails'
  gem 'factory_girl_rails'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'assert_difference'
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-remote'
  gem 'fuubar'
  gem 'rubocop'
  gem 'rubocop-rspec'
end

group :development do
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'quiet_assets'
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'guard-rubocop'
  gem 'guard-rails'
  gem 'guard-bundler'
  gem 'guard-puma'
  gem 'guard-brakeman'
  gem 'rb-fsevent', require: false
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'bullet'
  gem 'rack-mini-profiler'
end

group :development, :production do
  gem 'puma'
end

group :production do
  gem 'rails_12factor'
  gem 'rails_serve_static_assets'
  gem 'airbrake'
  gem 'newrelic_rpm'
end
