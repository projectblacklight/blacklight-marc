module Blacklight::Marc
  module Catalog
    extend ActiveSupport::Concern

    included do
      blacklight_config.add_show_tools_partial(:librarian_view, if: :render_librarian_view_control?, define_method: false)
      blacklight_config.add_show_tools_partial(:refworks, if: :render_refworks_action?, modal: false)
      blacklight_config.add_show_tools_partial(:endnote, if: :render_endnote_action?, modal: false, path: :single_endnote_catalog_path, define_method: false)
    end

    def librarian_view
      deprecator = ActiveSupport::Deprecation.new
      if Blacklight::VERSION >= '8'
        @document = search_service.fetch(params[:id])
        @response = ActiveSupport::Deprecation::DeprecatedObjectProxy.new(@document.response, "The @response instance variable is deprecated and will be removed in Blacklight-marc 8.0", deprecator)

      else
        deprecated_response, @document = search_service.fetch(params[:id])
        @response = ActiveSupport::Deprecation::DeprecatedObjectProxy.new(deprecated_response, "The @response instance variable is deprecated and will be removed in Blacklight-marc 8.0", deprecator)
      end

      respond_to do |format|
        format.html do
          return render layout: false if request.xhr?
          # Otherwise draw the full page
        end
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
