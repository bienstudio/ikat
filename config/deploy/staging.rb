set :rails_env, :staging
set :rack_env,  :staging

set :branch, 'master'

role :app, %w{ubuntu@staging.getikat.com}

server 'staging.getikat.com', user: 'ubuntu', roles: %w{app}
