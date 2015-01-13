source 'https://rubygems.org'
ruby '2.1.2'
# Rails
gem 'rails', '4.1.6'

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

gem 'sass-rails',   '>= 3.2'
gem 'bootstrap-sass', '~> 3.1.1'
gem 'uglifier', '>= 1.0.3'
gem 'jquery-rails'
gem 'jquery-ui-rails', '~> 5.0.0'
gem 'gmaps-autocomplete-rails'
gem 'turbolinks'
gem 'jquery-turbolinks'
gem 'nprogress-rails'
gem 'font-awesome-rails'

group :test do
  gem 'database_cleaner'
  gem 'codeclimate-test-reporter', require: nil
  gem 'shoulda-matchers', require: false
  gem 'simplecov'
  gem 'faker'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'launchy'
  gem 'vcr'
end

group :test, :development do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'assert_difference'
  gem 'byebug'
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-remote'
  gem 'dotenv-rails'
  gem 'fuubar'
  gem 'rubocop'
end

group :development do
  gem 'rails-footnotes', '>= 3.7.9'
  gem 'quiet_assets'
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'guard-rubocop'
  gem 'guard-rails'
  gem 'guard-bundler'
  gem 'guard-cucumber'
  gem 'guard-puma'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'rb-fsevent', require: false
  gem 'better_errors'
  gem 'binding_of_caller'
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

