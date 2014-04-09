require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Lunchtime
  class Application < Rails::Application
    config.active_record.observers = :vote_observer
    config.autoload_paths += Dir["#{config.root}/app/controllers/supports"]
  end
end
