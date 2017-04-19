Apipie.configure do |config|
  config.app_name                = "Address Book API"
  config.api_base_url            = "/"
  config.doc_base_url            = "/docs"
  config.app_info                = "API created for STRV job opportunity"
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/{[!concerns/]**/*,*}.rb"
  config.reload_controllers = Rails.env.development?
  config.api_routes = Rails.application.routes
end
