source 'https://rubygems.org'

# Specify your gem's dependencies in blacklight_marc.gemspec
gemspec

gem 'simplecov', :platform => :mri

group :test do
  gem 'devise'
  gem 'devise-guests'
  gem "bootstrap-sass"
  gem 'turbolinks'
  gem "unicode", :platforms => [:mri_18, :mri_19]
end

if File.exists?('spec/test_app_templates/Gemfile.extra')
  eval File.read('spec/test_app_templates/Gemfile.extra'), nil, 'spec/test_app_templates/Gemfile.extra'
end