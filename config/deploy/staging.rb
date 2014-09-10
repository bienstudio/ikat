set :rails_env, :staging

role :app, %w{ubuntu@staging.getikat.com}

server 'staging.getikat.com', user: 'ubuntu', roles: %w{app}
