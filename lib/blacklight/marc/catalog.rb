module Blacklight::Marc
  module Catalog
    def librarian_view
      @response, @document = get_solr_response_for_doc_id params[:id]

      respond_to do |format|
        format.html
        format.js { render :layout => false }
      end
    end

    # grabs a bunch of documents to export to endnote
    def endnote
      @response, @documents = get_solr_response_for_document_ids(params[:id])
      respond_to do |format|
        format.endnote { render :layout => false }
      end
    end
  end
end
