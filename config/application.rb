require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Catalyst
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.external_url = URI(ENV.fetch('EXTERNAL_URL', 'http://localhost:3000'))
    config.running_in_docker = File.exist?('/.dockerenv')

    config.log_level = ENV.fetch('LOG_LEVEL', 'info')

    # Prepend all log lines with the a per-request UUID (this helps tie multi-line log events together with each other and with events from a downstream Nginx, for example).
    config.log_tags = [:uuid]

    # Use a log formatter which both includes progname and correctly tags multi-line log events
    config.log_formatter = -> (severity, time, progname, msg) do
      line_prefix = severity[0, 1] << ' '
      line_prefix << "[#{progname}] " if progname.present?
      first_line, *lines = msg.split("\n")
      if (m = /\A(?:\[.+?\] )+/.match(first_line))
        line_prefix << m.to_s
        first_line = m.post_match
      end
      lines.inject(line_prefix + first_line << "\n") do |string, line|
        string << line_prefix << line << "\n"
      end
    end
  end
end
