set :rails_env, :production

role :app, %w{ubuntu@getikat.com}

server 'getikat.com', user: 'ubuntu', roles: %w{app}
