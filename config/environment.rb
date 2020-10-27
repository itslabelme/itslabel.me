# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
ActionMailer::Base.smtp_settings = {
  :user_name => 'apikey',
  #:password => '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',
  :password => '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',
  #:domain => 'asnathira@gmail.com',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}