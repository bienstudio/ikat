ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'

SimpleCov.start 'rails'

require File.expand_path('../../config/environment', __FILE__)

require 'rspec/rails'

require 'carrierwave/test/matchers'
require 'sidekiq/testing'

Sidekiq::Testing.fake!

FactoryGirl::SyntaxRunner.class_eval do
  include ActionDispatch::TestProcess
end

RSpec.configure do |conf|
  conf.include FactoryGirl::Syntax::Methods
  conf.include VCR::RSpec::Macros
  conf.include CarrierWave::Test::Matchers

  # Tag an example with the `:focus` metadata to only run them
  conf.filter_run :focus
  conf.run_all_when_everything_filtered = true

  # More verbose output for files that are ran individually
  if conf.files_to_run.one?
    conf.default_formatter = 'doc'
  end

  # Show the slowest 10 examples on each run
  # conf.profile_examples = 5

  conf.before :suite do
    # Set the DatabaseCleaner strategy before the suite runs
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)

    # FactoryGirl.lint
  end

  conf.before :each do
    Sidekiq::Worker.clear_all
  end

  conf.before do
    # Start DatabaseCleaner collecting transactions
    DatabaseCleaner.start
  end

  # Clean the database
  conf.after do
    DatabaseCleaner.clean
  end

  conf.after(:each) do
    FileUtils.rm_rf(Dir["#{Rails.root}/spec/support/uploads"])
  end
end

VCR.configure do |conf|
  conf.cassette_library_dir = 'spec/fixtures/cassettes'
  conf.hook_into :webmock
  conf.default_cassette_options = { record: :new_episodes, match_requests_on: [:host] }
  conf.debug_logger = File.open('log/vcr.log', 'w')
end
