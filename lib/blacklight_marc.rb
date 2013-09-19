require "blacklight_marc/version"
require 'blacklight'
module BlacklightMarc
  Blacklight::Solr::Document.autoload :Marc, 'blacklight/solr/document/marc'
  Blacklight::Solr::Document.autoload :MarcExport, 'blacklight/solr/document/marc_export'
  
  require 'blacklight_marc/engine'
  require 'blacklight_marc/railtie'
  autoload :Routes, 'blacklight_marc/routes'
  autoload :Catalog, 'blacklight_marc/catalog'

  def self.add_routes(router, options = {})
    BlacklightMarc::Routes.new(router, options).draw
  end
end
