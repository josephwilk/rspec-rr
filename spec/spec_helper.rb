ENV["RAILS_ENV"] = "test"
require  File.dirname(__FILE__) + "/../config/environment"
require 'rspec/rails'
require 'rspec/rr'

RSpec.configure do |config|
  config.mock_with :rr
end
