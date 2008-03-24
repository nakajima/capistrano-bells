namespace :deploy do
  namespace :db do
    desc "Runs rake db:create on remote server"
    task :create do
      run "cd #{current_path} && RAILS_ENV=#{mongrel_environment} rake db:create"
    end
  end

  task :restart do
    eval("#{app_server.to_s}.restart")
  end
  
  task :start do
    eval("#{app_server.to_s}.start")
  end
  
  task :stop do
    eval("#{app_server.to_s}.stop")
  end

  desc "Shows tail of production log"
  task :tail do
    stream "tail -f #{current_path}/log/production.log"
  end
  
  desc "Show tail of mongrel log"
  task :tail_mongrel do
    stream "tail -f #{current_path}/log/mongrel.log"
  end

  # after "deploy:update_code", "deploy:copy_config_files"
  desc "Copy production database.yml to live app"
  task :copy_config_files do
    config_files.each do |file|
      run "cp #{shared_path}/config/#{file} #{release_path}/config/"
    end
  end
end