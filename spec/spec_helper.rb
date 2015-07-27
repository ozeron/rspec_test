require 'rspec'
require 'rspec/collection_matchers'
require 'byebug'

APP_ROOT = File.dirname __dir__
$: << APP_ROOT
$: << File.join(APP_ROOT, "lib")

DATA_PATH = File.join(APP_ROOT, 'spec', 'data')
require 'gps_receiver'

Dir[File.join(APP_ROOT, 'spec/support/**/**.rb')].each { |p| require(p) }
Utility::Logger.supress_logs!

RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = false
  end

  config.order = :random
  Kernel.srand config.seed
end
