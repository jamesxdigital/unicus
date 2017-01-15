##Applicationdeploymentconfiguration

set :server, 'epi-stu-hut-demo2.shef.ac.uk'
set :user,   'demo.team21'
set :deploy_to, -> {"/srv/services/#{fetch(:user)}"}
set :log_level, :debug

##Serverconfiguration
server fetch(:server), user: fetch(:user), roles: %w{web app db}

##Additionaltasks
namespace :deploy do
  task :seed do
    on primary :db do within current_path do with rails_env: fetch(:stage) do
      execute :rake, 'db:seed'
    end end end
  end
end
