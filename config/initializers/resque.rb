require 'resque/status_server'
require 'resque/job_with_status'
Resque.redis = ENV['REDISTOGO_URL']
Resque::Plugins::Status::Hash.expire_in = (24 * 60 * 60)