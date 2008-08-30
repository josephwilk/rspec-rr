ENV["RAILS_ENV"] = "test"

dir = File.dirname(__FILE__)
$LOAD_PATH.unshift(File.expand_path("#{dir}/../../rspec/lib"))
$LOAD_PATH.unshift(File.expand_path("#{dir}/../../rspec-rails/lib"))
$LOAD_PATH.unshift(File.expand_path("#{dir}/../lib"))

require  "#{dir}/../../../../config/environment"
require 'spec/rails'
require 'spec/rr'

Spec::Runner.configure do |config|
  config.mock_with :rr
end
