source 'https://rubygems.org'

# Specify your gem's dependencies in blacklight_marc.gemspec
gemspec

gem 'simplecov', :platform => :mri
gem 'blacklight'

if File.exists?('spec/test_app_templates/Gemfile.extra')
  eval File.read('spec/test_app_templates/Gemfile.extra'), nil, 'spec/test_app_templates/Gemfile.extra'
end