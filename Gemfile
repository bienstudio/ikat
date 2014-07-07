source 'https://rubygems.org'

ruby '2.1.2'

gem 'rails', '4.1.1'

gem 'mongoid', '4.0.0.beta2'

gem 'puma'

gem 'turbolinks'

gem 'devise'
gem 'canable'

gem 'paperclip', github: 'eturk/paperclip'
gem 'aws-sdk', '~> 1.3.4'

gem 'mutations'

gem 'haml-rails'

gem 'sass-rails', '~> 4.0.3'
gem 'compass-rails'
gem 'susy'

gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'uglifier', '>= 1.3.0'


group :development, :test do
  gem 'rubocop'

  gem 'log_buddy'
end

group :development, :production do
  gem 'pry-rails'
end

group :development do
  gem 'foreman'

  gem 'better_errors'
  gem 'binding_of_caller'

  gem 'spring'
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
