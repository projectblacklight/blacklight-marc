require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require 'engine_cart/rake_task'

EngineCart.fingerprint_proc = EngineCart.rails_fingerprint_proc

RSpec::Core::RakeTask.new(:spec)

task :default => [:ci]

task :ci => ['engine_cart:generate'] do
  require 'solr_wrapper'
  SolrWrapper.wrap(port: '8983') do |solr|
    solr.with_collection(name: 'blacklight-core', dir: File.join(File.expand_path(File.dirname(__FILE__)), "solr", "conf")) do
      Rake::Task["blacklight_marc:fixtures"].invoke
      Rake::Task['spec'].invoke
    end
  end
end


namespace :blacklight_marc do

  desc "Load fixtures"
  task :fixtures => ['engine_cart:generate'] do
    within_test_app do
      system "bundle exec rake solr:marc:index_test_data RAILS_ENV=test"
      abort "Error running fixtures" unless $?.success?
    end
  end
end
