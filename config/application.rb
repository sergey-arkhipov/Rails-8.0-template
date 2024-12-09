require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
# Global APP setup
module Rails80Template
  # Default config and some config settings
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = "Europe/Moscow"
    # config.eager_load_paths << Rails.root.join("extras")
    # if ENV["RAILS_LOG_TO_STDOUT"].present?
    #   $stdout.sync = true
    #   config.rails_semantic_logger.add_file_appender = false
    #   config.semantic_logger.add_appender(
    #     io: $stdout,
    #     formatter: config.rails_semantic_logger.format
    #     # Filter out log entries healthcheck
    #     # filter: /Rails::HealthController/
    #   )
    # end
    config.log_level = ENV["LOG_LEVEL"].downcase.strip.to_sym if ENV["LOG_LEVEL"].present?
    config.rails_semantic_logger.started = true
    config.rails_semantic_logger.processing = true
    config.rails_semantic_logger.rendered   = true
    config.rails_semantic_logger.console_logger = false
    config.log_tags = {
      request_id: :request_id,
      ip: :remote_ip,
      user: ->(request) { request.cookie_jar["login"] }
    }
  end
end
