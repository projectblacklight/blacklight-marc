module Blacklight::Marc
  module Catalog
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
