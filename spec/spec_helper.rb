ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)

require 'rspec/rails'
require 'paperclip/matchers'

RSpec.configure do |conf|
  conf.include FactoryGirl::Syntax::Methods
  conf.include VCR::RSpec::Macros
  conf.include Paperclip::Shoulda::Matchers

  # Tag an example with the `:focus` metadata to only run them
  conf.filter_run :focus
  conf.run_all_when_everything_filtered = true

  # More verbose output for files that are ran individually
  if conf.files_to_run.one?
    conf.default_formatter = 'doc'
  end

  # Show the slowest 10 examples on each run
  conf.profile_examples = 10

  # Set the DatabaseCleaner strategy before the suite runs
  conf.before :suite do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  # Start DatabaseCleaner collecting transactions
  conf.before do
    DatabaseCleaner.start
  end

  # Clean the database
  conf.after do
    DatabaseCleaner.clean
  end
end

VCR.configure do |conf|
  conf.cassette_library_dir = 'spec/fixtures/cassettes'
  conf.hook_into :webmock
  conf.default_cassette_options = { record: :all }
  conf.debug_logger = File.open('log/vcr.log', 'w')
  # conf.around_http_request do |request|
  #   VCR.use_cassette('suite', record: :once, &request)
  # end
end
