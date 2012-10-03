require 'bundler/capistrano'

default_run_options[:pty] = true

# Defaults
set :application, 'pro-digital-photos'
set :deploy_to, "~/www/#{application}"
set :use_sudo, false

# Git
set :repository,  'git@github.com:plaidlock/pro-digital-photos.git'
set :branch, 'master'

# More Git
set :scm, 'git'
set :git_shallow_clone, 1
set :git_enable_submodules, 1

set :user, 'prodigit'

# Set RAILS_ENV to production
set :rails_env, 'production'

# Configs
role :web, '50.22.11.10'
role :app, '50.22.11.10'
role :db,  '50.22.11.10', :primary => true

# Clean up old deploys
after "deploy", "deploy:cleanup"

# Create .htaccess
after 'deploy:create_symlink', 'pdphotos:drop_htaccess'
namespace 'pdphotos' do
  task :drop_htaccess, :roles => :app do
    htaccess = "#{current_path}/public/.htaccess"
    run "if [ ! -f #{htaccess} ]; then echo 'PassengerEnabled On' > #{htaccess}; echo 'PassengerAppRoot #{current_path}' >> #{htaccess}; echo '.htaccess created'; else echo '.htaccess already exists (untouched)'; fi"
  end
end
