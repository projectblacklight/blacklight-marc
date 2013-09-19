module BlacklightMarc
  class Railtie < Rails::Railtie
    rake_tasks do
      load "railties/solr_marc.rake"
    end

    initializer 'blacklight_marc.initialize' do |app|
      Mime::Type.register "application/marc", :marc
      Mime::Type.register "application/marcxml+xml", :marcxml, 
      ["application/x-marc+xml", "application/x-marcxml+xml", 
       "application/marc+xml"]
     end
  end
end