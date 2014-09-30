lock '3.2.1'

set :application, 'ikat'

set :scm, :git
set :repo_url, 'git@github.com:eturk/ikat.git'

set :deploy_to, '/data/ikat'

set :rbenv_custom_path, '/home/deplou/.rbenv'
set :rbenv_ruby, '2.1.3'

set :linked_files, %w{.env}

set :sockets_path, Pathnew.new("#{fetch(:deploy_to)}/shared/tmp/sockets/")

set :puma_roles, :app
set :puma_socket, "unix://#{fetch(:sockets_path).join('puma_' + fetch(:application) + '.sock')}"
set :pumactl_socket, "unix://#{fetch(:sockets_path).join('pumactl_' + fetch(:application) + '.sock')}"
set :puma_state, fetch(:sockets_path).join('puma.state')
set :puma_log, -> { shared_path.join("log/puma-#{fetch(:stage )}.log") }
set :puma_flags, nil

set :asset_roles, [:app]

set :current_rails_env, ->{ fetch(:rails_env) }

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
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
