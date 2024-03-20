module BlacklightMarcHelper
  def refworks_export_url params = {}, *_
    "https://www.refworks.com/express/expressimport.asp?vendor=#{CGI.escape(params[:vendor] || application_name)}&filter=#{CGI.escape(params[:filter] || "MARC Format")}&encoding=65001" + (("&url=#{CGI.escape(params[:url])}" if params[:url]) || "")
  end

  def refworks_solr_document_path opts = {}, *_
    if opts[:id]
      refworks_export_url(url: solr_document_url(opts[:id], format: :refworks_marc_txt))
    end
  end

  # For exporting a single endnote document. (endnote_catalog_path is defined by blacklight-marc and it is used for multiple document export)
  def single_endnote_catalog_path opts = {}, **kwargs
    solr_document_path(opts['id'], **kwargs.merge(opts).merge(format: 'endnote').except('id'))
  end


  # puts together a collection of documents into one refworks export string
  def render_refworks_texts(documents)
    val = ''
    documents.each do |doc|
      if doc.exports_as? :refworks_marc_txt
        val += doc.export_as(:refworks_marc_txt) + "\n"
      end
    end
    val
  end

  # puts together a collection of documents into one endnote export string
  def render_endnote_texts(documents)
    val = ''
    documents.each do |doc|
      if doc.exports_as? :endnote
        endnote = doc.export_as(:endnote)
        val += "#{endnote}\n" if endnote
      end
    end
    val
  end

  # A URL to refworks export, with an embedded callback URL to this app.
  # the callback URL is to bookmarks#export, which delivers a list of
  # user's bookmarks in 'refworks marc txt' format -- we tell refworks
  # to expect that format.
  def bookmarks_export_url(format, params = {})
    bookmarks_url(params.merge(format: format, encrypted_user_id: encrypt_user_id(current_or_guest_user.id)))
  end
end
