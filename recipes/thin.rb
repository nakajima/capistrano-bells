namespace :thin do
  desc "Configure a new thin cluster"
  task :configure, :roles => :app do
    argv = []
    argv << "thin config"
    argv << "-s #{app_servers.to_s}"
    argv << "-p #{app_server_port.to_s}"
    argv << "-e #{app_environment}"
    argv << "-a #{app_server_address}"
    argv << "-c #{current_path}"
    argv << "-C #{app_server_conf}"
    cmd = argv.join " "
    sudo cmd
  end
  
  desc "Start thin servers"
  task :start do
    run "thin start -C #{app_server_conf}"
  end
  
  desc "Stop thin servers"
  task :stop do
    run "thin stop -C #{app_server_conf}"
  end
  
  desc "Restart thin servers"
  task :restart do
    run "thin restart -C #{app_server_conf}"
  end
end