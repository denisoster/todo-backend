Apipie.configure do |config|
  config.app_name                = 'Todo'
  config.doc_base_url            = '/apipie'
  config.api_base_url            = ''
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/{[!concerns/]**/*,*}.rb"
  config.translate               = false
  config.default_locale          = nil
end
