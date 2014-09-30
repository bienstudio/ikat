set :rails_env, :development
set :rack_env,  :development

set :branch, '41-deploy'

role :app, %w{deploy@localhost:2222}

server 'localhost', user: 'deploy', roles: %w{app}
