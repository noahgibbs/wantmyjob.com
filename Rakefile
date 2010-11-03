# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

begin
  require 'delayed/tasks'
rescue LoadError
  STDERR.puts "Run 'bundle:install' to install delayed_job"
end

task :cron_daily => [:environment] do |t|
  Note.generate_daily_feed_stats
  UtterlyNaiveMatch.create_matches_for :all
end

task :cron_hourly => [:environment] do |t|

end

# "rake jobs:work" for delayed_job - do it through god?

Wantmyjob::Application.load_tasks
