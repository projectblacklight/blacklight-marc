require 'rails/generators'

module BlacklightMarc
  class MarcGenerator < Rails::Generators::Base

    source_root File.expand_path('../templates', __FILE__)

    desc """
     1. Creates config/SolrMarc/... with settings for SolrMarc
     2. Creates a CatalogController with some some demo fields for MARC-like data
     3. Injects MARC-specific behaviors into the SolrDocument
    """
    
    # Copy all files in templates/config directory to host config
    def create_configuration_files
      directory("config/SolrMarc")
    end

    # add MARC-specific extensions to the solr document
    def add_marc_extension_to_solrdocument

      insert_into_file "app/models/solr_document.rb", :after => "include Blacklight::Solr::Document" do <<EOF
    
      # The following shows how to setup this blacklight document to display marc documents
  extension_parameters[:marc_source_field] = :marc_display
  extension_parameters[:marc_format_type] = :marcxml
  use_extension( Blacklight::Solr::Document::Marc) do |document|
    document.key?( :marc_display  )
  end
  
  field_semantics.merge!(    
                         :title => "title_display",
                         :author => "author_display",
                         :language => "language_facet",
                         :format => "format"
                         )

EOF
      end
    end

  end
end
