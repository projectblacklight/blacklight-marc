require "blacklight/marc"
require "rails"

module Blacklight::Marc
  class Engine < Rails::Engine
    config.autoload_paths += %W(
      #{config.root}/app/presenters
      #{config.root}/app/controllers/concerns
      #{config.root}/app/models/concerns
    )

    rake_tasks do
      load "railties/solr_marc.rake"
    end

    initializer 'blacklight_marc.initialize' do |app|
      require 'blacklight/solr/document'

      Mime::Type.register_alias "text/plain", :refworks_marc_txt
      Mime::Type.register_alias "text/plain", :openurl_kev
      Mime::Type.register "application/x-endnote-refer", :endnote
      Mime::Type.register "application/marc", :marc
      Mime::Type.register "application/marcxml+xml", :marcxml,
      ["application/x-marc+xml", "application/x-marcxml+xml",
       "application/marc+xml"]
     end
  end
end
