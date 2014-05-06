module BlacklightMarcHelper

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
        val += doc.export_as(:endnote) + "\n"
      end
    end
    val
  end
end
