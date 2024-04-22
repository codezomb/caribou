ENV["RAILS_ENV"] = "test"

# -------------------------------------------------------
# SimpleCov must be required before all things
# -------------------------------------------------------
require "simplecov"

if ENV["RSWAG_DRY_RUN"].nil?
  SimpleCov.minimum_coverage(98)
  SimpleCov.start("rails")
end

# -------------------------------------------------------
# Require all other files needed for testing
# -------------------------------------------------------
require File.expand_path("../config/environment", __dir__)
require "factory_bot_rails"
require "database_cleaner"
require "rspec/rails"
require "faker"

Dir[Rails.root.join("spec", "models", "concerns", "*.rb")].each { |f| require f }
Dir[Rails.root.join("spec", "support", "**", "*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include ActiveSupport::Testing::TimeHelpers
  config.include FactoryBot::Syntax::Methods

  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = false

  config.order = "random"

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.after do
    Faker::UniqueGenerator.clear
  end
end
