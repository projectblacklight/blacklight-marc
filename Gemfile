source 'https://rubygems.org'

# Please see blacklight_marc.gemspec for dependency information.
gemspec path: File.expand_path('..', __FILE__)


# Peg simplecov to < 0.8 until this is resolved:
# https://github.com/colszowka/simplecov/issues/281
gem 'simplecov', '~> 0.7.1', require: false
gem 'coveralls', require: false

file = File.expand_path("Gemfile", ENV['ENGINE_CART_DESTINATION'] || ENV['RAILS_ROOT'] || File.expand_path("../spec/internal", __FILE__))
if File.exists?(file)
  puts "Loading #{file} ..." if $DEBUG # `ruby -d` or `bundle -v`
  instance_eval File.read(file)
else
  gem 'rails', ENV['RAILS_VERSION']

  # explicitly include sass-rails to get compatible sprocket dependencies
  if ENV['RAILS_VERSION'] and ENV['RAILS_VERSION'] =~ /^4.2/
    gem 'sass-rails', ">= 5.0.0.beta1"
    gem 'responders', "~> 2.0"
  else
    gem 'sass-rails', "< 5.0"
    gem 'coffee-rails', "~> 4.0.0"
  end
end