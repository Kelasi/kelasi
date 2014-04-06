# Collection of tasks to manage public submodule

namespace :public do

  desc 'Initialize submodule system'
  task :init do
    sh "git submodule update --init"
  end

  desc 'Fetch latest version of public repo from github'
  task :update do
    sh "cd public && git pull origin master"
  end
end
