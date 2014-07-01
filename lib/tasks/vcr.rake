namespace :vcr do
  desc 'Clear all VCR cassettes'
  task :clear do
    exec('rm -rf ./spec/fixtures/cassettes/*')
  end
end
