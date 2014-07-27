require ::File.expand_path('../config/environment',  __FILE__)

map '/api/v1' do
  run Ikat::API
end

map '/' do
  run Ikat::Application
end
