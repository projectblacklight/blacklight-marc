require "bundler/gem_tasks"
APP_ROOT = File.expand_path("..", __FILE__)

TEST_APP_TEMPLATES = 'spec/test_app_templates'
TEST_APP = 'spec/internal'

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => [:ci]

desc "Run specs"
task :ci => ['blacklight_marc:generate', 'spec'] do |t|
end

namespace :blacklight_marc do
  desc "Create the test rails app"
  task :generate do
    unless File.exists?('spec/internal/Rakefile')
      puts "Generating rails app"
      `rails new #{TEST_APP}`
      puts "Copying gemfile"
      open("#{TEST_APP}/Gemfile", 'a') do |f|
        f.write File.read(TEST_APP_TEMPLATES + "/Gemfile.extra")
        f.write "gem 'blacklight_marc', :path => '../../'" 
      end
      puts "Copying generator"
      `cp -r #{TEST_APP_TEMPLATES}/lib/generators #{TEST_APP}/lib`
      within_test_app do
        puts "Bundle install"
        `bundle install`
        puts "running test_app_generator"
        system "rails generate test_app"

        puts "running migrations"
        puts `rake db:migrate db:test:prepare`
      end
    end
    puts "Done generating test app"
  end
end
def within_test_app
  FileUtils.cd(TEST_APP)
  Bundler.with_clean_env do
    yield
  end
  FileUtils.cd(APP_ROOT)
end
