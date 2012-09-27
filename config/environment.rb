# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Staff::Application.initialize!

# Initialize the CAS Gem
CASClient::Frameworks::Rails::Filter.configure(
  :cas_base_url => "https://www.thekey.me/cas/"
)
