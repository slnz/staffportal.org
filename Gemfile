source 'https://rubygems.org'
ruby '2.1.0'
# Rails
gem 'rails', '4.1.1'

# Postgres
gem 'pg'

# Authentication & Authorization
gem 'devise'
gem 'devise_cas_authenticatable'
gem 'symmetric-encryption'
gem 'cancancan'

# Queue
gem 'redis'
gem 'resque'
gem 'resque-retry'
gem 'resque-status'
gem 'hirefire-resource'

# Currency
gem 'open_exchange_rates'

# API
gem 'feedjira'
gem 'gravatarify'
gem 'httparty'
gem 'httparty-cookies'

# Controller
gem 'inherited_resources'
gem 'paperclip'
gem 'aws-sdk'
gem 'fiscali'

# View
gem 'breadcrumbs_on_rails'
gem 'formtastic'
gem 'formtastic-bootstrap'
gem 'kaminari-bootstrap'
gem 'haml'
gem 'table_for_collection'

# Javascript
gem 'highcharts-rails'
gem 'summernote-rails'
gem 'chosen-rails'

# Administration
gem 'activeadmin', github: 'gregbell/active_admin'
gem 'airbrake'

group :assets do
  gem 'sass-rails',   '>= 3.2'
  gem 'bootstrap-sass', '~> 3.1.1'
  gem 'font-awesome-rails'
  gem 'uglifier', '>= 1.0.3'
  gem 'jquery-rails'
end

group :development, :production do
  gem 'puma'
end

group :development, :test do
  gem 'spring-commands-rspec'
  gem 'rspec-rails'
  gem 'dotenv-rails'
end

group :development do
  gem 'pry-rails'
  gem 'pry-debugger'
  gem 'foreman'
  gem 'travis'
  gem 'rails-erd'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'spring'
  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-rspec'
  gem 'guard-spring'
  gem 'guard-rubocop'
end

group :test do
  gem 'rake'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'oauth2'
  gem 'fuubar'
  gem 'factory_girl_rails'
  gem "codeclimate-test-reporter", require: nil
  gem 'simplecov', :require => false
end

group :production do
  gem 'rails_12factor'
end
