module Blacklight::Marc
  class Engine < Rails::Engine
    rake_tasks do
      load "railties/solr_marc.rake"
    end

    initializer 'blacklight_marc.initialize' do |app|
      Mime::Type.register_alias "text/plain", :refworks_marc_txt
      Mime::Type.register_alias "text/plain", :openurl_kev
      Mime::Type.register "application/x-endnote-refer", :endnote
      Mime::Type.register "application/marc", :marc
      Mime::Type.register "application/marcxml+xml", :marcxml,
      ["application/x-marc+xml", "application/x-marcxml+xml",
       "application/marc+xml"]

       # these are here for backwards compatibility with the old class names,
       # which zeitwerk didn't care for
       config.after_initialize do
         Blacklight::Solr::Document::Marc = Blacklight::Marc::DocumentExtension
         Blacklight::Solr::Document::MarcExport = Blacklight::Marc::DocumentExport
       end
     end
  end
end
