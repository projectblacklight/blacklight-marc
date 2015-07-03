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
  require 'spec_helper'

  describe '#document_action_path' do
    before do
      allow(helper).to receive_messages(controller_name: 'catalog')
    end

    let(:document_action_config) { Blacklight::Configuration::ToolConfig.new(tool_config) }
    let(:document) { SolrDocument.new(id: '123') }

    subject { helper.document_action_path(document_action_config, id: document) }

    context "for endnote" do
      let(:tool_config) { { if: :render_refworks_action?, partial: "document_action",
        name: :endnote, key: :endnote, path: :single_endnote_catalog_path } }

      it { is_expected.to eq '/catalog/123.endnote' }
    end
  end

end
