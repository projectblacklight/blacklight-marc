module Blacklight::Marc
  module Catalog
    extend ActiveSupport::Concern

    included do
      add_show_tools_partial(:librarian_view, if: :render_librarian_view_control?)
      add_show_tools_partial(:refworks, if: :render_refworks_action?, modal: false)
      add_show_tools_partial(:endnote, if: :render_endnote_action?, modal: false, path: :single_endnote_catalog_path )
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
  end
end
