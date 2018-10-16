require 'spec_helper'

describe 'bookmarks/_endnote.html.erb' do
  before do
    allow(controller).to receive(:blacklight_config).and_return(CatalogController.blacklight_config)
  end

  it "should have a link" do
    assign(:document_list, [mock_model(Bookmark, document_id: 7, exports_as?: true), mock_model(Bookmark, document_id: 8, exports_as?: true)])
    render
    expect(rendered).to have_link "Export to EndNote"
  end
end
