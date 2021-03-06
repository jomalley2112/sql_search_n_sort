# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'equivalent-xml'
# require 'rspec/autorun'
require 'database_cleaner'
require 'capybara/rails'
require 'capybara/rspec'
require "selenium-webdriver"
require 'factory_bot'
require 'pry'


# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  #config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false
  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    FactoryBot.reload
  end

  config.expect_with :rspec do |expectations|
    # expectations.include_chain_clauses_in_custom_matcher_descriptions = true
    expectations.syntax = [:should, :expect]
  end

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
  config.include Capybara::DSL
  config.include FactoryBot::Syntax::Methods
  config.include Rails.application.routes.url_helpers
  config.example_status_persistence_file_path = "rspec-example-persistence"
end

#JOM Commented out to test on windows
# caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {"args" => [ "--disable-extensions" ]})
# Capybara.register_driver :selenium do |app|
#   Capybara::Selenium::Driver.new(app, :browser => :chrome, desired_capabilities: caps)
# end

def same_order?(model, field, arr, asc=true)
  if asc
    model.sql_sort(field.to_sym, :asc).map { |e| e.send(field) }.uniq == 
      arr.sort_by{ |p| p.send(field) }.map { |e| e.send(field) }.uniq
  else
    model.sql_sort(field.to_sym, :desc).map { |e| e.send(field) }.uniq == 
      arr.sort_by{ |p| p.send(field) }.reverse.map { |e| e.send(field) }.uniq
  end

end

def run_generator
  cmd_str = 'rails g sql_search_n_sort:install  --quiet --force' 
  puts "\n#{cmd_str}"
  %x(#{cmd_str})
  #Need to reload ApplicationController because it was edited by the generator
  load "#{ Rails.root }/app/controllers/application_controller.rb"
  #Need to reload because it was created by generator
  load("#{Rails.root}/config/initializers/sql_search_n_sort.rb")
end

def run_destroy
  cmd_str = 'rails d sql_search_n_sort:install  --quiet --force' 
  puts "\n#{cmd_str}"
  %x(#{cmd_str})
end
