require "blacklight_marc/version"
require 'blacklight'
module BlacklightMarc
  Blacklight::Solr::Document.autoload :Marc, 'blacklight/solr/document/marc'
  Blacklight::Solr::Document.autoload :MarcExport, 'blacklight/solr/document/marc_export'
  
  require 'blacklight_marc/railtie'
end
