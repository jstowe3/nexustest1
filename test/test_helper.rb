ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'rspec-rails'
require 'rspec/mocks'
require 'rspec/mocks/standalone'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here..
  #

  SimpleCov.configure do

     SimpleCov.add_filter '/app/views/'
     SimpleCov.add_filter '/db/'
     SimpleCov.add_filter '/config/'
     #SimpleCov.add_filter '/test/'

  end

end
