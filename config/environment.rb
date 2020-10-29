# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
ActionMailer::Base.smtp_settings = {
  :user_name => 'apikey',
  #:password => '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',
  :password => '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',
  #:password => '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',
  #:domain => '',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}