#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Staff::Application.load_tasks

require 'resque/tasks'

task "resque:setup" => :environment do
  ENV['QUEUE'] ||= '*'
  Resque.before_fork = Proc.new { ActiveRecord::Base.establish_connection }
end

task "jobs:work" => "resque:work"
