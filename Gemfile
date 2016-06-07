source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '>= 5.0.0.rc1', '< 5.1'
ruby '2.2.4'
gem 'dotenv-rails'

# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.0'
gem 'active_model_serializers', '~> 0.10.0'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

# Heroku deployment
gem 'rails_12factor'

gem 'paypal-sdk-rest'
gem 'paypal-sdk-invoice'
gem 'paypal-sdk-merchant'

# Emails to clients
gem 'sendgrid-ruby' #, :git => 'https://github.com/sendgrid/sendgrid-ruby', :branch => 'v3beta'
gem 'statsample'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :test do
  gem 'faker'

  # RSPEC for Rails 5
  gem "rails-controller-testing", git: "https://github.com/rails/rails-controller-testing"
  gem "rspec-rails", "3.5.0.beta4"
  # with additional matchers
  gem 'shoulda-matchers', '~> 3.1.1'

  # Testing Coverage
  gem 'simplecov', require: false
  gem 'coveralls', require: false

  # Verify JSON APIs
  gem 'json-schema'
end
