require 'spec_helper'

describe 'bookmarks/_endnote.html.erb' do
  it "should have a link" do
    assign(:bookmarks, [mock_model(Bookmark, document_id: 7), mock_model(Bookmark, document_id: 8)])
    render
    expect(rendered).to have_link "Export to EndNote"
  end
end
