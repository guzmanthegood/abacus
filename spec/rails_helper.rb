ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'
require 'spec_helper'
require 'devise'

require 'capybara/rails'
require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'capybara/poltergeist'

include Warden::Test::Helpers

I18n.default_locale = :es

ActiveRecord::Migration.maintain_test_schema!

Capybara.exact = true
Capybara.javascript_driver = :poltergeist
Capybara::Screenshot.autosave_on_failure = true
Capybara::Screenshot.webkit_options = { width: 1920, height: 1080 }

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.include Devise::Test::ControllerHelpers, :type => :controller

  config.before :each, :js, type: :feature do
    page.driver.resize_window(1920, 1080)
  end
end