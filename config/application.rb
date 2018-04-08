require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BookClub
  class Application < Rails::Application
    # Load application ENV vars and merge with existing ENV vars.
    # Loaded here so can use values in initializers.
    config.before_configuration do
      ENV.update YAML.load_file('config/application.yml')[Rails.env] rescue {}
    end

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
