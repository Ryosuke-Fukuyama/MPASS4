# config valid for current version and patch releases of Capistrano
lock "~> 3.17.1"

set :application, "MPASS4"
set :repo_url, "https://github.com/Ryosuke-Fukuyama/MPASS4.git"

# Default branch is :master
ask :branch, 'aws_ver', `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/secrets.yml .env}

# Default value for linked_dirs is []
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets public/uploads} # SSHKit::Command::Failed   Permission denied

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 5


# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

set :rbenv_version, '3.0.4'
set :log_level, :info

after 'deploy:published', 'deploy:seed'
after 'deploy:finished', 'deploy:restart'

namespace :deploy do
  # Rake::Task["deploy:check:directories"].clear
  # Rake::Task["deploy:check:linked_dirs"].clear

  # namespace :check do
  #   desc '(overwrite) Check shared and release directories exist'
  #   task :directories do
  #     on release_roles :all do
  #       execute :sudo, :mkdir, '-pv', shared_path, releases_path
  #     end
  #   end
  #   task :linked_dirs do
  #     next unless any? :linked_dirs
  #     on release_roles :all do
  #       execute :sudo, :mkdir, '-pv', linked_dirs(shared_path)
  #     end
  #   end
  # end

  desc 'Run seed'
  task :seed do
    on roles(:db) do
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:seed'
        end
      end
    end
  end
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end
end