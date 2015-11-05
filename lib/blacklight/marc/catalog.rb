module Blacklight::Marc
  module Catalog
    extend ActiveSupport::Concern

    included do
      add_show_tools_partial(:librarian_view, if: :render_librarian_view_control?, define_method: false)
      add_show_tools_partial(:refworks, if: :render_refworks_action?, modal: false)
      add_show_tools_partial(:endnote, if: :render_endnote_action?, modal: false, path: :single_endnote_catalog_path, define_method: false)
    end

    def librarian_view
      @response, @document = fetch params[:id]

      respond_to do |format|
        format.html
        format.js { render :layout => false }
      end
    end

    # grabs a bunch of documents to export to endnote
    def endnote
      @response, @documents = fetch(Array(params[:id]))
      respond_to do |format|
        format.endnote { render :layout => false }
      end
    end

    private

    def render_refworks_action? config, options = {}
      options[:document] && options[:document].respond_to?(:export_formats) && options[:document].export_formats.keys.include?(:refworks_marc_txt )
    end

    def render_endnote_action? config, options = {}
      options[:document] && options[:document].respond_to?(:export_formats) && options[:document].export_formats.keys.include?(:endnote )
    end

    def render_librarian_view_control? config, options = {}
      respond_to? :librarian_view_solr_document_path and options[:document] and options[:document].respond_to?(:to_marc)
    end

  end
end
