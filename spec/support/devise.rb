# Config devise gem for rspec
RSpec.configure do |config|
  config.include Devise::Test::IntegrationHelpers, type: :request
end
