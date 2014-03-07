# A Magic to import seeds to tests.
# !Don't use it!

namespace :db do
  namespace :test do
    task :prepare => :environment do
      Rake::Task["db:seed"].invoke
    end
  end
end
