require 'rails/generators'

module Blacklight::Marc
  class InstallGenerator < Rails::Generators::Base

    source_root File.expand_path('../templates', __FILE__)

    desc """
     1. Creates config/SolrMarc/... with settings for SolrMarc
     2. Creates a CatalogController with some some demo fields for MARC-like data
     3. Creates a MarcIndexer model
     4. Injects MARC-specific behaviors into the SolrDocument
     5. Injects MARC-specific behaviors into the CatalogController
    """

    source_root File.expand_path('../templates', __FILE__)

    def assets
      append_to_file "app/assets/stylesheets/application.bootstrap.scss" do
<<-EOF

@import 'blacklight_marc';
EOF
      end
    end

    # Copy all files in templates/config directory to host config
    def create_configuration_files
      directory("config/translation_maps")
    end

    def create_models
      copy_file "app/models/marc_indexer.rb", "app/models/marc_indexer.rb"
    end
    # add MARC-specific extensions to the solr document
    def add_marc_extension_to_solrdocument

      insert_into_file "app/models/solr_document.rb", :after => "include Blacklight::Solr::Document" do <<EOF

      # The following shows how to setup this blacklight document to display marc documents
  extension_parameters[:marc_source_field] = :marc_ss
  extension_parameters[:marc_format_type] = :marcxml
  use_extension(Blacklight::Marc::DocumentExtension) do |document|
    document.key?(SolrDocument.extension_parameters[:marc_source_field])
  end

  field_semantics.merge!(
                         :title => "title_ssm",
                         :author => "author_ssm",
                         :language => "language_ssim",
                         :format => "format"
                         )

EOF
      end
    end

    # Add MARC behaviors to the catalog controller
  def inject_blacklight_controller_behavior
    inject_into_file "app/controllers/catalog_controller.rb", after:"include Blacklight::Catalog" do
      "\n  include Blacklight::Marc::Catalog\n"
    end
  end


  def inject_blacklight_marc_routes
    route <<-EOF
    concern :marc_viewable, Blacklight::Marc::Routes::MarcViewable.new
    EOF

    inject_into_file "config/routes.rb", after: "resources :solr_documents, only: [:show], path: '/catalog', controller: 'catalog' do" do
      "\n    concerns [:exportable, :marc_viewable]\nINJECT_FLAG"
    end
    gsub_file "config/routes.rb", /[\n]INJECT_FLAG\s+concerns \:exportable/,""
  end

  end
end
