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
    queue 'bower install'
    # queue 'bundle exec jekyll build'
    # queue 'rm -rf .asset-cache/sprockets/*'
    queue 'JEKYLL_ENV=production bundle exec jekyll build'
    # queue 'rm -rf _site_backup/*'
    # queue 'mv _site _site_backup && mv _site2 _site'
    # queue 'cp _site/index.html _site/index2.html'
    queue 'gzip -r -k --best ./_site'
  end
end