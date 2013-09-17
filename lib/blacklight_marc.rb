require "blacklight_marc/version"

module BlacklightMarc
  class Railtie < Rails::Railtie
    rake_tasks do
      load "railties/solr_marc.rake"
    end
  end
end
