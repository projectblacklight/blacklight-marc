require "blacklight_marc/version"

module BlacklightMarc
  class Railtie < Rails::Railtie
    rake_tasks do
      load "railties/solr_marc.rake"
    end

    initializer "blacklight MARC" do
      Blacklight::Solr::Document.autoload :Marc, 'blacklight/solr/document/marc'
      Blacklight::Solr::Document.autoload :MarcExport, 'blacklight/solr/document/marc_export'
    end
  end
end
