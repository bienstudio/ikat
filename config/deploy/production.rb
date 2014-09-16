set :rails_env, :production
set :rack_env,  :production

set :branch, 'master'

role :app, %w{ubuntu@getikat.com}

server 'getikat.com', user: 'ubuntu', roles: %w{app}
