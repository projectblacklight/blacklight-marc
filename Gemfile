source 'https://rubygems.org'

# Specify your gem's dependencies in blacklight_marc.gemspec
gemspec

group :test do
  gem 'devise'
  gem "bootstrap-sass"
  gem 'turbolinks'
  gem 'activerecord-jdbcsqlite3-adapter', :platforms => :jruby
end

if File.exists?('spec/test_app_templates/Gemfile.extra')
  eval File.read('spec/test_app_templates/Gemfile.extra'), nil, 'spec/test_app_templates/Gemfile.extra'
end
