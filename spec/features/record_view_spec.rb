# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "Record View" do
  describe "Tools" do
    it "should have a refworks link" do
      visit solr_document_path('2008305903')
      expect(page).to have_link "Export to Refworks"
      link = find_link("Export to Refworks")
      expect(link['href']).to include CGI.escape(solr_document_path('2008305903', format: :refworks_marc_txt))
    end

    it 'has an endnote link' do
      visit solr_document_path('2008305903')
      expect(page).to have_link "Export to EndNote", href: solr_document_path('2008305903', format: :endnote)
    end
  end
end
