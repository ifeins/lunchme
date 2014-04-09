require File.expand_path('../boot', __FILE__)

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
require 'rails/all'

Bundler.require(*Rails.groups)

module Lunchtime
  class Application < Rails::Application
    # Configure sensitive parameters which will be filtered from the log file.
    config.active_record.observers = :vote_observer
    config.autoload_paths += Dir["#{config.root}/app/controllers/supports"]
  end
end
