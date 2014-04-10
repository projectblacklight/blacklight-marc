source 'https://rubygems.org'

# Please see blacklight_marc.gemspec for dependency information.
gemspec path: File.expand_path('..', __FILE__)


# Peg simplecov to < 0.8 until this is resolved:
# https://github.com/colszowka/simplecov/issues/281
gem 'simplecov', '~> 0.7.1', require: false
gem 'coveralls', require: false

gem 'engine_cart', '~> 0.3.0'
group :test do
  gem 'activerecord-jdbcsqlite3-adapter', :platforms => :jruby
end

file = File.expand_path("Gemfile", ENV['ENGINE_CART_DESTINATION'] || ENV['RAILS_ROOT'] || File.expand_path("../spec/internal", __FILE__))
if File.exists?(file)
  puts "Loading #{file} ..." if $DEBUG # `ruby -d` or `bundle -v`
  instance_eval File.read(file)
end
