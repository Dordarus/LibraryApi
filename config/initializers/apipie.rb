Apipie.configure do |config|
  config.app_name                = "LibraryApi"
  config.api_base_url            = ""
  config.doc_base_url            = "/apipie"
  config.copyright = "&copy; 2018 Daniel Vysotskyi"
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/{[!concerns/]**/*,*}.rb"
  config.app_info["1.0"] = "Superusefull Library Api"
  config.validate = false
end