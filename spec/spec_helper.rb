# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

# Clearance's custom matchers
require 'clearance/testing'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec

  # Each test is run against a clean database, unless you set this false.
  # http://stackoverflow.com/questions/8749524/why-is-my-test-database-empty-before-and-after-running-rails-test
  config.use_transactional_fixtures = true
end
