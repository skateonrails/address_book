class Rack::Attack
  # `Rack::Attack` is configured to use the `Rails.cache` value by default,
  # but you can override that by setting the `Rack::Attack.cache.store` value
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  # Allow all local traffic
  safelist('allow-localhost') do |req|
    '127.0.0.1' == req.ip || '::1' == req.ip
  end

  # Allow an IP address to make 60 requests every 1 minute
  # Do not throttle docs files
  throttle('req/ip', limit: 60, period: 1.minute) do |req|
    req.ip unless req.path.start_with?('/docs')
  end

  # Send the following response to throttled clients
  self.throttled_response = ->(env) {
    retry_after = (env['rack.attack.match_data'] || {})[:period]
    [
      429,
      {'Content-Type' => 'application/json', 'Retry-After' => retry_after.to_s},
      [{error: "Throttle limit reached. Retry later."}.to_json]
    ]
  }
end
