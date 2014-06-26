ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)

require 'rspec/rails'
require 'rspec/autorun'

RSpec.configure do |conf|
  conf.include FactoryGirl::Syntax::Methods

  # Tag an example with the `:focus` metadata to only run them.
  conf.filter_run :focus
  conf.run_all_when_everything_filtered = true

  # More verbose output for files that are ran individually.
  if conf.files_to_run.one?
    conf.default_formatter = 'doc'
  end

  # Show the slowest 10 examples on each run.
  conf.profile_examples = 10

  conf.before :suite do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  conf.before do
    DatabaseCleaner.start
  end

  conf.after do
    DatabaseCleaner.clean
  end
end
