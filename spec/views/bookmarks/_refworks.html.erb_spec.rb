require 'spec_helper'

describe 'bookmarks/_refworks.html.erb' do
  it "should have a link" do
    assign(:document_list, [mock_model(Bookmark, document_id: 7), mock_model(Bookmark, document_id: 8)])
    render
    expect(rendered).to have_button "Export to Refworks"
  end
end

