require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TestRailsDelayedjobMailerSimpleform
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Queue Jobs using delayed_job
    config.active_job.queue_adapter = :delayed_job

    # Action Mailer : host (no browser url request, no way to detect automatically, requires define manually)
    config.action_mailer.default_url_options = { host: "#{Rails.application.credentials[Rails.env.to_sym][:host]}" }

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
