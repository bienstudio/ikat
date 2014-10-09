source 'https://rubygems.org'

ruby '2.1.2'

gem 'rails', '4.1.4'

gem 'mongoid', '>= 4.0.0'
gem 'mongoid-ancestry'

gem 'puma'

gem 'turbolinks'

gem 'sidekiq'
gem 'sidekiq-status', github: 'utgarda/sidekiq-status'

gem 'pusher'

gem 'sinatra'

gem 'devise'
gem 'canable'

gem 'carrierwave-mongoid', require: 'carrierwave/mongoid'
gem 'mini_magick'
gem 'fog'
gem 'carrierwave_backgrounder'

gem 'mutations'

gem 'nokogiri'
gem 'fastimage'

gem 'rails_admin'#, github: 'eturk/rails_admin'

gem 'haml-rails'
gem 'rabl'
gem 'oj'

gem 'sass-rails', '~> 4.0.3'
gem 'compass-rails'
gem 'susy'

gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jquery-turbolinks'
gem 'uglifier', '>= 1.3.0'
gem 'gon'

gem 'non-stupid-digest-assets'
gem 'asset_sync'
gem 'unf'

gem 'tugboat'

gem 'dotenv'
gem 'dotenv-deployment'

gem 'better_errors'
gem 'binding_of_caller'

group :development, :test do
  gem 'sinatra-contrib', require: false

  gem 'rubocop'

  gem 'log_buddy'
end

group :development, :production do
  gem 'pry-rails'
end

group :staging, :production do
  gem 'sentry-raven'
end

group :development do
  gem 'foreman'

  # gem 'sass-rails-source-maps'

  gem 'capistrano'
  gem 'capistrano-rails'#, github: 'eturk/rails'
  gem 'capistrano-rbenv', github: 'joost/rbenv'
  gem 'capistrano-bundler'
  gem 'capistrano-sidekiq'
end

group :test do
  gem 'rspec-rails', '3.0.1'

  gem 'shoulda-matchers'
  gem 'factory_girl_rails'

  gem 'vcr'
  gem 'webmock', require: 'webmock/rspec'

  gem 'database_cleaner'

  gem 'simplecov', require: false
end
