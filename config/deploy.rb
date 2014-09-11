# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'ikat'
set :repo_url, 'git@github.com:eturk/ikat.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/var/www/ikat'

# Default value for :scm is :git
set :scm, :git

# set :rbenv_type, :user
set :rbenv_custom_path, '/home/ubuntu/.rbenv'
set :rbenv_ruby, '2.1.2'

set :linked_files, %w{.env}

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

# ec2_roles :name => :web

# set :keypair, 'ikat-aws.pem'
# set :keypair_full_path, "#{ENV['HOME']}/.ssh/#{keypair}"

# set :ssh_options, {
#   forward_agent: true,
#   keys: keypair_full_path
# }

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :mkdir, '-p', "#{ release_path }/tmp"
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  # after :publishing, :assets

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  desc 'Reload the database with seed data'
  task :seed do
    on "ubuntu@staging.fanzter.com" do
      execute "cd #{current_path}; bundle exec rake db:seed RAILS_ENV=staging; exit"
    end
  end

end
