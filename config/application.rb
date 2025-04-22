# config/application.rb
require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module WeddingPhotographyPlatform
  class Application < Rails::Application
    config.load_defaults 8.0
    
    # Disable assets pipeline (add these lines)
    config.assets_enabled = false
    config.generators.assets = false
    
    # Configure default time zone
    config.time_zone = 'UTC'
    
    # Configure generators
    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_bot
      g.stylesheets false
      g.javascripts false
      g.helper false
    end
  end
end