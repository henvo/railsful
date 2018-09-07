require 'simplecov'
SimpleCov.start

require 'active_record'
require 'bundler/setup'
require 'action_controller'
require 'railsful'

require 'support/test_controller'
require 'support/dummy'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
