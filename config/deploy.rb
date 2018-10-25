require 'mina/rails'
require 'mina/git'
require 'mina/puma'
require 'mina/rbenv'

set :domain, '185.65.247.99'
set :port, '22'
set :forward_agent, true
set :deploy_to, '/home/todo/web/todo.osterdev.com'
set :repository, 'git@github.com:denisoster/todo-backend.git'
set :branch, 'master'
set :user, 'todo'
set :rails_env, 'production'
set :application_name, 'todo-backend'
set :shared_dirs, fetch(:shared_dirs, []).push(
    'tmp/pids',
    'tmp/sockets',
    'public/uploads'
)
set :shared_files, fetch(:shared_files, []).push(
    'config/database.yml',
    'config/master.key'
)

task :remote_environment do
  invoke :'rbenv:load'
end

task :setup do
  command %(mkdir -p "#{fetch(:deploy_to)}/shared/tmp/sockets")
  command %(chmod g+rx,u+rwx "#{fetch(:deploy_to)}/shared/tmp/sockets")

  command %(mkdir -p "#{fetch(:deploy_to)}/shared/tmp/pids")
  command %(chmod g+rx,u+rwx "#{fetch(:deploy_to)}/shared/tmp/pids")

  command %(mkdir -p "#{fetch(:deploy_to)}/shared/pids/")
  command %(mkdir -p "#{fetch(:deploy_to)}/shared/log/")
  command %(mkdir -p "#{fetch(:deploy_to)}/shared/public/uploads/")

  command %(touch "#{fetch(:deploy_to)}/shared/config/database.yml")
  command %(touch "#{fetch(:deploy_to)}/shared/config/master.key")
end

task :deploy do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'deploy:cleanup'

    on :launch do
      in_path(fetch(:current_path)) do
        invoke :remote_environment
        invoke :'puma:phased_restart'
      end
    end
  end
end
