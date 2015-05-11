require 'mina/git'
require 'mina/bundler'
require 'mina/rbenv'

set :domain, ENV['srv'] || 'roi.rs'
set :user, 'deploy'
set :repository, '/home/deploy/repo/roi.rs.git'
set :deploy_to, '/home/deploy/apps/roi.rs'


task :deploy do
  invoke 'rbenv:load'

  deploy do
    #Base
    invoke 'git:clone'
    # invoke 'deploy:link_shared_paths'
    invoke 'bundle:install'
    
    
    
    #Assets
    queue 'bower install --force-latest'
    queue 'coffee -c -b -o vendor/javascripts app/javascripts'
    queue 'browserify vendor/javascripts/application.js --debug | exorcist public/javascripts/application.js.map > public/javascripts/application.js'
    queue 'bundle exec compass compile'
    queue 'gzip -r -k --best ./public'
  end
end