require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
  RSpec.configure do |config|
    config.mock_with :rspec
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.use_transactional_fixtures = true
    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.filter_run :focus => true
    config.run_all_when_everything_filtered = true
  end
end

Spork.each_run do
  FactoryGirl.reload
end

def controller_actions(controller)
  Rails.application.routes.routes.inject({}) do |hash, route|
    if route.requirements[:controller] == controller && !route.verb.nil?
      hash[route.requirements[:action]] = route.verb.downcase.empty? ? "get" : route.verb.downcase
    end
    hash
  end
end

def login(username,password)
  visit login_path
  fill_in "Login", :with => username
  fill_in "Password", :with => password
  click_button "Login"
end
