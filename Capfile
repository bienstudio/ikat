require 'capistrano/setup'

require 'capistrano/deploy'
require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/rails'
require 'capistrano/sidekiq'
require 'capistrano/puma'
require 'capistrano/puma/workers' #if you want to control the workers (in cluster mode)
require 'capistrano/puma/jungle'  #if you need the jungle tasks
require 'capistrano/puma/monit'   #if you need the monit tasks
require 'capistrano/puma/nginx'   #if you want to upload a nginx site template

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
