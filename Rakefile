require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require 'engine_cart/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => [:ci]

task :ci => ['engine_cart:generate'] do
  require 'solr_wrapper'

  SolrWrapper.wrap(port: '8983') do |solr|
    solr.with_collection(name: 'blacklight-core', dir: File.join(__dir__, "solr", "conf")) do
      Rake::Task['fixtures'].invoke
      Rake::Task['spec'].invoke
    end
  end
end

desc "Load fixtures"
task :fixtures => ['engine_cart:generate'] do
  within_test_app do
    ENV['RAILS_ENV'] ||= 'test'
    system "rake blacklight:index:seed"
    abort "Error running fixtures" unless $?.success?
  end
end
