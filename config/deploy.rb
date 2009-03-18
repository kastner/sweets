  default_run_options[:pty] = true
  
  set :use_sudo, false
  
  set :ssh_options, { :forward_agent => true }
  set :domain, "metaatem"
  
  set :application, "sweets"
  set :repository,  "git@github.com:kastner/sweets.git"
  set :deploy_to, "/var/www/sweets"
  set :scm, :git
  set :git_enable_submodules, 1
  set :deploy_via, :remote_cache
  set :git_shallow_clone, 1
  
  set :group, "www-data"
  
  role :app, domain
  role :web, domain
  role :db,  domain, :primary => true
  
  namespace :deploy do
    %w|start restart|.each do |t|
      task t do
        run "touch #{current_path}/tmp/restart.txt"
      end
    end
  end
  
  desc "Link production files"
  task :after_symlink do
    run "ln -nfs #{shared_path}/system/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/system/action_mailer_configs.rb #{release_path}/config/initializers/action_mailer_configs.rb"
  end
  
  task :after_setup do
    put File.read('config/database.yml'), "#{shared_path}/system/database.yml"
    put File.read('config/initializers/action_mailer_configs.rb'), "#{shared_path}/system/action_mailer_configs.rb"
  end
