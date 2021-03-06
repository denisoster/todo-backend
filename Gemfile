source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

# Pagination
gem 'pagy', '~> 0.21.0'
# JSON:API serializer
gem 'fast_jsonapi', '~> 1.4'
# File uploader
gem 'carrierwave', '~> 1.2', '>= 1.2.3'
# Devise Token Auth
gem 'devise_token_auth', '~> 1.0'
# Simple authorization
gem 'cancancan', '~> 2.3'
# Documentation
gem 'apipie-rails', '~> 0.5.13'
# Blazing fast application deployment tool.
gem 'mina', '~> 1.2', '>= 1.2.3', require: false
# Puma tasks for Mina
gem 'mina-puma', '~> 1.1', require: false
# Library for setting test data
gem 'factory_bot_rails', '~> 4.11', '>= 4.11.1'
# A library for generating fake data such as names, addresses, and phone numbers.
gem 'faker', '~> 1.9', '>= 1.9.1'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  # RSpec for Rails-3+
  gem 'rspec-rails', '~> 3.8'

  # Code coverage for Ruby 1.9+ with a powerful configuration library and automatic merging of coverage across test suites
  gem 'simplecov', '~> 0.16.1'
  # Strategies for cleaning databases in Ruby. Can be used to ensure a clean state for testing.
  gem 'database_cleaner', '~> 1.7'
  # RuboCop for RSpec
  gem 'rubocop-rspec', '~> 1.30'
  # Collection of testing matchers extracted from Shoulda
  gem 'shoulda-matchers', '~> 3.1'
  # Extracting `assigns` and `assert_template` from ActionDispatch.
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.2'
  # Enhances Rails credentials for multiple environments
  gem 'rails-env-credentials', '~> 0.1.3'  
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # RuboCop for Rails
  gem 'rubocop', '~> 0.59.2'
  # Awesome Print AP
  gem 'awesome_print', '~> 1.8'  
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
