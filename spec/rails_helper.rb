ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path('dummy/config/environment', __dir__)

require 'rspec/rails'
require 'database_cleaner'
require 'aker'
require 'factory_bot'
require 'rails-controller-testing'

def reload_menus!
  ActiveAdmin.application.namespaces.each(&:reset_menu!)
end

def reload_routes!
  Rails.application.reload_routes!
end

ActiveAdmin.application.load_paths = [File.expand_path('dummy/app/admin', __dir__)]
ActiveAdmin.unload!
ActiveAdmin.load!
reload_menus!
reload_routes!

ActiveAdmin.application.authentication_method = false
ActiveAdmin.application.current_user_method = false

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.infer_spec_type_from_file_location!
end
