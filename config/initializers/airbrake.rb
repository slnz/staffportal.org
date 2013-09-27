Airbrake.configure do |config|
  config.api_key = '77d84d8486df7208f9986374fe232e40'
  config.host    = 'errors.studentlife.org.nz'
  config.port    = 80
  config.secure  = config.port == 443
end
