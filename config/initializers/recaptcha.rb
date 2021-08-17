Recaptcha.configure do |config|
  case Rails.env
  when "development"
    config.site_key  = Rails.application.credentials.development[:captcha][:site_key]
    config.secret_key = Rails.application.credentials.development[:captcha][:secret_key]
  when "staging"
    config.site_key  = Rails.application.credentials.staging[:captcha][:site_key]
    config.secret_key = Rails.application.credentials.staging[:captcha][:secret_key]
  when "production"
    config.site_key  = Rails.application.credentials.production[:captcha][:site_key]
    config.secret_key = Rails.application.credentials.production[:captcha][:secret_key]
  end  
end