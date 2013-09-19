$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

ENV["RAILS_ENV"] ||= 'test'

ruby_engine = defined?(RUBY_ENGINE) ? RUBY_ENGINE : "ruby"
if ENV['COVERAGE'] and RUBY_VERSION =~ /^1.9/ and ruby_engine != "jruby"
  require 'simplecov'

  SimpleCov.start do
    root File.expand_path(File.dirname(__FILE__) + "../../..")
  end
end

require File.expand_path("config/environment", ENV['RAILS_ROOT'] || File.expand_path("../internal", __FILE__))

require 'rspec/rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
# Blacklight, again, make sure we're looking in the right place for em. 
# Relative to HERE, NOT to Rails.root, which is off somewhere else. 
Dir[Pathname.new(File.expand_path("../support/**/*.rb", __FILE__))].each {|f| require f}

RSpec.configure do |config|

end
