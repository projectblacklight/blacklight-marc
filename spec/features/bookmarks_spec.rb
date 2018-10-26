require 'spec_helper'

describe "Bookmark tools" do
  it "should have an endnote export" do
    visit solr_document_path('2007020969')
    click_button 'Bookmark'
    visit "/bookmarks.endnote?q="
    expect(page).to have_content " %@ 9780743297790"
  end

  it "should have a refworks export" do
    visit solr_document_path('2007020969')
    click_button 'Bookmark'
    visit "/bookmarks.refworks_marc_txt?q="
    # modern capybara normalizes whitespace so don't check for strict nbsp
    expect(page).to have_content "LEADER 01490cam a2200361 a 4500001"
  end
end
