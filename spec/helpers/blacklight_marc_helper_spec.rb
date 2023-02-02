require 'spec_helper'

describe BlacklightMarcHelper do
  let(:one) { SolrDocument.new }
  let(:two) { SolrDocument.new }
  describe "render_refworks_texts" do
    before do
      allow(one).to receive_messages(export_as_refworks_marc_txt: 'one')
      allow(two).to receive_messages(export_as_refworks_marc_txt: 'two')
    end
    it "should render_refworks_texts" do
      expect(helper.render_refworks_texts([one, two])).to eq "one\ntwo\n"

    end
  end

  describe "render_endnote_texts" do
    before do
      allow(one).to receive_messages(export_as_endnote: 'one')
      allow(two).to receive_messages(export_as_endnote: 'two')
    end
    it "should render_endnote_texts" do
      expect(helper.render_endnote_texts([one, two])).to eq "one\ntwo\n"
    end
  end

  describe "#bookmarks_export_url" do
    it "is the bookmark url with an encrypted user token" do
      allow(helper).to receive_messages(encrypt_user_id: 'xyz', current_or_guest_user: double(id: 123))
      url = helper.bookmarks_export_url(:html)
      expect(url).to eq helper.bookmarks_url(format: :html, encrypted_user_id: 'xyz')
    end
  end
end
