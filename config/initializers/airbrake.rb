Airbrake.configure do |config|
  config.api_key = ENV['airbrake_api_key']
  config.host    = 'errors.studentlife.org.nz'
  config.port    = 80
  config.secure  = config.port == 443
end
