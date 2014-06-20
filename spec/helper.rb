require 'rspec'
require 'webmock/rspec'
require 'pry'
require 'httparty'

require 'httpfiesta'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.include WebMock::API
end
