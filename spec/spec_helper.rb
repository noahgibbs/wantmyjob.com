# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'devise/test_helpers'
require 'factory_girl'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  #config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  #config.before(:suite) do
  #  DatabaseCleaner.clean_with(:truncation)
  #  DatabaseCleaner.strategy = :transaction
  #end

  #config.before(:each) do
  #  DatabaseCleaner.start
  #end

  #config.before(:each) do
  #  DatabaseCleaner.clean
  #end
end

module AppSpecHelpers

  def self.included(mod)
    mod.instance_eval do
      include Devise::TestHelpers

      before(:each) do
        # mock up an authentication in the underlying warden library
        request.env['warden'] = mock(Warden, :authenticate => mock_user,
                                     :authenticate! => mock_user)
      end
    end
  end

  def mock_ar_object(obj_name, stubs = {})
    eval "@mock_#{obj_name} ||= mock_model(#{obj_name.capitalize}).as_null_object"
    instance_variable_get("@mock_#{obj_name}").stub(stubs) unless stubs.empty?
    instance_variable_get("@mock_#{obj_name}")
  end

  def mock_user(stubs = {})
    mock_ar_object("user", stubs)
  end

end
