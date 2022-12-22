# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
# lock "~> 3.15.0"

set :application, 'todo-api'
set :repo_url, 'git@github.com:blacksyan/Todo-list-API.git'

set :deploy_to, '/home/deploy/www/todo-api'
append :linked_files, 'config/database.yml', 'config/master.key'

append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', '.bundle', 'public/system',
       'public/uploads', 'storage'

# Default branch is :master
set :branch, -> { `git rev-parse --abbrev-ref HEAD`.chomp }

# Only keep the last 5 releases to save disk space
set :keep_releases, 3

set :rbenv_type, :user
set :rbenv_ruby, '2.7.2'

# Passenger
set :passenger_roles, :app
set :passenger_restart_runner, :sequence
set :passenger_restart_wait, 10
set :passenger_restart_limit, 2
set :passenger_restart_with_sudo, false
set :passenger_restart_with_touch, true
set :passenger_restart_command, 'passenger stop && passenger start --daemonize --address 127.0.0.1 --port 3000'
set :passenger_restart_options, -> { "#{deploy_to}/current" }

# Nginx
set :nginx_roles, :web
set :nginx_sudo_paths, []
set :nginx_sudo_tasks, ['nginx:restart']

# Used to build for optimized production
namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles fetch(:nginx_roles) do
      execute :sudo, '/etc/init.d/nginx restart'
    end
  end

  after :finishing, :restart
end

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
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
