require 'spec_helper'

RSpec.describe 'bookmarks/_refworks' do
  before do
    allow(controller).to receive(:blacklight_config)
      .and_return(CatalogController.blacklight_config)
    allow(view).to receive_messages(encrypt_user_id: 1)
    allow(view).to receive_messages(current_or_guest_user: mock_model(User))
    assign(:response, response)
    render
  end

  let(:response) do
    instance_double(Blacklight::Solr::Response,
                    documents: documents)
  end
  let(:documents) do
    [mock_model(Bookmark, document_id: 7, exports_as?: true),
     mock_model(Bookmark, document_id: 8, exports_as?: true)]
  end

  it 'has a link' do
    expect(rendered).to have_link 'Export to Refworks'
  end
end
