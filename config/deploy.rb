lock '3.2.1'

set :application, 'ikat'
set :repo_url, 'git@github.com:eturk/ikat.git'

set :deploy_to, '/var/www/ikat'

set :scm, :git

set :rbenv_custom_path, '/home/ubuntu/.rbenv'
set :rbenv_ruby, '2.1.2'

set :linked_files, %w{.env}

set :asset_roles, [:app]

set :current_rails_env, ->{ fetch(:rails_env) }

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :mkdir, '-p', "#{ release_path }/tmp"
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  # before :starting, 'deploy:setup_env'

  after :publishing, :restart

  after :publishing, 'deploy:compile_assets'

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      within release_path do
        execute :rake, 'assets', 'precompile'
      end
    end
  end
  #
  # desc 'Set the RACK_ENV and RAILS_ENV environment variables.'
  # task :setup_env do
  #   on roles(:app) do
  #     within release_path do
  #       env = fetch(:current_rails_env)
  #
  #       execute "export RACK_ENV=#{env}; export RAILS_ENV=#{env}"
  #     end
  #   end
  # end
  #
  # namespace :assets do
  #   desc 'Precompile assets'
  #   task :precompile do
  #     on roles(:app) do
  #       within release_path do
  #         env = fetch(:current_rails_env)
  #
  #         execute "export RACK_ENV=#{env}; export RAILS_ENV=#{env}"
  #         execute :rake, "assets:precompile"
  #
  #       end
  #     end
  #   end
  # end
end
