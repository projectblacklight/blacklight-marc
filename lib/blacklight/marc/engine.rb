require "blacklight/marc"
require "rails"

module Blacklight::Marc
  class Engine < Rails::Engine
    config.autoload_paths += %W(
      #{config.root}/lib
    )
  end
end
