require 'mina/git'
require 'mina/bundler'
require 'mina/rbenv'

set :domain, ENV['srv'] || 'roi.rs'
set :user, 'deploy'
set :repository, 'git@github.com:ROI-RS/roi.rs.git'
set :deploy_to, '/home/deploy/apps/roi.rs'
set :branch, 'master'

task :deploy do
  invoke 'rbenv:load'

  deploy do
    #Base
    invoke 'git:clone'
    # invoke 'deploy:link_shared_paths'
    invoke 'bundle:install'
    queue 'bundle exec jekyll build'
    queue 'gzip -r -k --best ./_site'    
  end
end