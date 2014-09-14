set :rails_env, :staging
set :rack_env,  :staging

set :branch, '7-deploy'

role :app, %w{ubuntu@staging.getikat.com}

server 'staging.getikat.com', user: 'ubuntu', roles: %w{app}
