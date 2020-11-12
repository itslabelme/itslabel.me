# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
ActionMailer::Base.smtp_settings = {
  :user_name => Rails.application.credentials.production[:sendgrid][:username],
  :password => Rails.application.credentials.production[:sendgrid][:api_key],
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true,
  :domain => 'demo.itslabel.me',
}