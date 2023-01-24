source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.4'
gem 'activerecord-import'

# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
# Use Puma as the app server
gem 'puma', '~> 4.3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# HTTP Clients
# gem 'net-http'
gem 'rest-client'

# enable soft delete
gem "paranoia", "~> 2.2"

gem "kaminari", '~> 1.0', '>= 1.0.1'
gem 'bootstrap4-kaminari-views'
gem 'country_select'

#payment gateway
gem 'stripe'

# Wikded PDF
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false


# Gems used in this Application
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'

#Gem for captcha
gem "recaptcha", require: "recaptcha/rails"


gem 'active_storage_validations'
# for import data
gem 'iconv', "~> 1.0"
gem 'colorize'

gem 'ngram'

# For text area auto completion
gem 'tribute'

gem 'rubyzip', '>= 1.2.1'
gem 'axlsx', git: 'https://github.com/randym/axlsx.git', ref: 'c8ac844'
# gem 'axlsx_rails'
gem 'caxlsx_rails'

#gem 'aws-ses', '~> 0.4.4', require: 'aws/ses'
gem 'sendgrid-ruby'
gem 'ancestry'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'pry', '~> 0.12.2'
  gem 'byebug'
end

group :development do

  # FIXME - This is not working for some reason
  # gem "awesome_print", require:"ap"
  # gem 'meta_request'

  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  # gem 'web-console', '>= 3.3.0'
  # gem 'listen', '>= 3.0.5', '< 3.2'

  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  # gem 'web-console', '>= 3.3.0'
  # gem 'listen', '>= 3.0.5', '< 3.2'
  
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # See https://github.com/rails/execjs#readme for more supported runtimes
  # gem 'therubyracer', platforms: :ruby

  gem "capistrano", require: false
  gem 'capistrano-rbenv',   require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano3-puma',   require: false
  gem 'capistrano-memcached',   require: false
end

group :test do

  # Adds support for factories and rspec
  gem 'rspec-rails', '~> 3.5'
  gem 'factory_bot_rails'

  gem "shoulda-matchers"
  gem 'database_cleaner'

  # Adds support for Capybara system testing and selenium driver
  # gem 'capybara', '>= 2.15'
  # gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  # gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
