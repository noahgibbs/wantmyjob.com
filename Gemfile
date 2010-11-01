source 'http://rubygems.org'

gem 'rails', '3.0.0'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mysql2'

gem 'decent_exposure', '~>1.0.0.rc1'

gem "devise", '~>1.1.2'

gem "delayed_job", :git => 'git://github.com/collectiveidea/delayed_job.git'
gem "paper_trail"

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri', '1.4.1'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end

# Development-only gems
group :development do
  gem 'mongrel'
end

# Test-only gems
group :test do
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem "database_cleaner"
end

# Dev-and-test gems -- usually for test-environment tools that
# also have generators or similar that you'd like to run from
# the command line without typing "RAILS_ENV=test rake foo:bar".
group :development, :test do
  gem "rspec-rails", "~> 2.0.0.beta.22"
  gem "capybara"
  gem "factory_girl_rails"
  gem "rails3-generators"
  gem "autotest"
end
