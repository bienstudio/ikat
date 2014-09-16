lock '3.2.1'

set :application, 'ikat'

set :scm, :git
set :repo_url, 'git@github.com:eturk/ikat.git'

set :deploy_to, '/var/www/ikat'

set :rbenv_custom_path, '/home/ubuntu/.rbenv'
set :rbenv_ruby, '2.1.2'

set :linked_files, %w{.env}

set :asset_roles, [:app]

set :current_rails_env, ->{ fetch(:rails_env) }

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :mkdir, '-p', "#{release_path}/tmp"
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  before :starting, 'deploy:setup_env'

  after :publishing, :restart

  after :publishing, 'deploy:assets:precompile'

  desc 'Set the RACK_ENV and RAILS_ENV environment variables.'
  task :setup_env do
    on roles(:app) do
      within release_path do
        env = fetch(:current_rails_env)

        execute "export RACK_ENV=#{env}; export RAILS_ENV=#{env}"
      end
    end
  end

  namespace :assets do
    desc 'Precompile assets for the correct environment.'
    task :precompile do
      on roles(:app) do
        within release_path do
          with rails_env: fetch(:current_rails_env) do
            execute :rake, "assets:precompile"
          end
        end
      end
    end
  end
end
