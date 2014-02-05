require "blacklight/marc/version"
require 'blacklight'

module Blacklight
  module Marc
    Blacklight::Solr::Document.autoload :Marc, 'blacklight/solr/document/marc'
    Blacklight::Solr::Document.autoload :MarcExport, 'blacklight/solr/document/marc_export'
  
    require 'blacklight/marc/engine'
    require 'blacklight/marc/railtie'
    autoload :Routes, 'blacklight/marc/routes'
    autoload :Catalog, 'blacklight/marc/catalog'

    def self.add_routes(router, options = {})
      Blacklight::Marc::Routes.new(router, options).draw
    end
  end
end