Rails.application.configure do
  config.action_mailer.default_url_options = {
    host: config.external_url.host,
    protocol: config.external_url.scheme, # ugh rails... it's the "scheme", not the protocol
  }

  # only set port if non-standard for the URL scheme:
  case config.external_url.scheme
  when 'http'
    config.action_mailer.default_url_options[:port] = config.external_url.port if config.external_url.port != 80
  when 'https'
    config.action_mailer.default_url_options[:port] = config.external_url.port if config.external_url.port != 443
  else
    fail "Unknown EXTERNAL_URL scheme #{scheme}"
  end
end
