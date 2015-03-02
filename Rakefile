require "bundler/gem_tasks"
ZIP_URL = "https://github.com/projectblacklight/blacklight-jetty/archive/v4.10.3.zip"

require 'jettywrapper'
require 'rspec/core/rake_task'
require 'engine_cart/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => [:ci]

task :ci => ['blacklight_marc:clean', 'blacklight_marc:generate'] do
  jetty_params = Jettywrapper.load_config('test')
  error = Jettywrapper.wrap(jetty_params) do
    Rake::Task["blacklight_marc:fixtures"].invoke
    Rake::Task['spec'].invoke
  end
  raise "test failures: #{error}" if error
end


namespace :blacklight_marc do

  desc "Load fixtures"
  task :fixtures => [:generate] do
    within_test_app do
      system "rake solr:marc:index_test_data RAILS_ENV=test"
      abort "Error running fixtures" unless $?.success?
    end
  end

  desc "Clean out the test rails app"
  task :clean => ['engine_cart:clean', 'jetty:clean'] do
  end

  desc "Create the test rails app"
  task :generate => ['engine_cart:generate'] do
  end
end
