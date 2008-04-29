# Recipe adapted from deprec gem
namespace :mongrel do
  desc <<-DESC
  Configure Mongrel processes on the app server. This uses the :use_sudo
  variable to determine whether to use sudo or not. By default, :use_sudo is
  set to true.
  DESC
  task :configure, :roles => :app do
    set_mongrel_conf
    
    argv = []
    argv << "mongrel_rails cluster::configure"
    argv << "-N #{app_servers.to_s}"
    argv << "-p #{app_server_port.to_s}"
    argv << "-e #{app_server_port}"
    argv << "-a #{app_server_address}"
    argv << "-c #{current_path}"
    argv << "-C #{app_server_conf}"
    cmd = argv.join " "
    sudo cmd
  end

  desc <<-DESC
  Start Mongrel processes on the app server.  This uses the :use_sudo variable to determine whether to use sudo or not. By default, :use_sudo is
  set to true.
  DESC
  task :start , :roles => :app do
    set_mongrel_conf
    run "mongrel_rails cluster::start -C #{app_server_conf}"
  end

  desc <<-DESC
  Restart the Mongrel processes on the app server by starting and stopping the cluster. This uses the :use_sudo
  variable to determine whether to use sudo or not. By default, :use_sudo is set to true.
  DESC
  task :restart , :roles => :app do
    set_mongrel_conf
    run "mongrel_rails cluster::restart -C #{app_server_conf}"
  end

  desc <<-DESC
  Stop the Mongrel processes on the app server.  This uses the :use_sudo
  variable to determine whether to use sudo or not. By default, :use_sudo is
  set to true.
  DESC
  task :stop , :roles => :app do
    set_mongrel_conf
    run "mongrel_rails cluster::stop -C #{app_server_conf}"
  end

  def set_mongrel_conf
    set :app_server_conf, "/etc/mongrel_cluster/#{application}.yml" unless app_server_conf
  end
end
