# config valid for current version and patch releases of Capistrano
lock "~> 3.18.0"

set :application, "qna"
set :repo_url, "git@github.com:alexpahom/qna.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :branch, 'main'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/deployer/qna"
set :deploy_user, 'deployer'

set :rvm_type, :user                     # Defaults to: :auto
set :rvm_ruby_version, '3.2.1'      # Defaults to: 'default'

set :bundle_jobs, 2

# Default value for :pty is false
set :pty, false

append :linked_files, "config/database.yml", 'config/master.key'

append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "vendor", "storage"

after 'deploy:publishing', 'unicorn:restart'
