lock '3.2.1'

set :application, 'ikat'
set :repo_url, 'git@github.com:eturk/ikat.git'

set :deploy_to, '/var/www/ikat'

set :scm, :git

set :rbenv_custom_path, '/home/ubuntu/.rbenv'
set :rbenv_ruby, '2.1.2'

set :linked_files, %w{.env}

set :asset_roles, [:app]

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :mkdir, '-p', "#{ release_path }/tmp"
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :publishing, 'deploy:assets:precompile'

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      within release_path do
        execute :rake, 'assets', 'precompile'
      end
    end
  end

  namespace :assets do
    desc 'Precompile assets'
    task :precompile do
      on roles(:app) do
        within current_path do
          execute :rake, 'assets:precompile'
        end
      end
    end
  end
end
