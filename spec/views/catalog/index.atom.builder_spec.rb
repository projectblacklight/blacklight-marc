require 'spec_helper'
require 'rexml/document'

describe "catalog/index" do
  before(:all) do
    @config = Blacklight::Configuration.new.configure do |config|
      config.default_solr_params = {
        fl: '*',
        rows: 10
      }
    end

    @params = { 'content_format' => 'marc', f: { format: ['Book'] }, page: 2 }
    service = Blacklight::SearchService.new(::CatalogController.blacklight_config, @params)

    # run a solr query to get our data
    c = CatalogController.new
    c.blacklight_config = @config
    @user_params = @params
    @response, @document_list = service.search_results
  end

  before(:each) do
    # Not sure what Assigns was doing here ... dhf
    #    assigns[:response] = @rsolr_response
    #    assigns[:document_list] = @document_list
    # not sure why we can't use assigns for 'params', instead this weird way,
    # but okay.

    params.merge!(@params)
    allow(view).to receive(:blacklight_config).and_return(@config)
    allow(view).to receive(:search_field_options_for_select).and_return([])

    render template: 'catalog/index', formats: [:atom]

    # We need to use rexml to test certain things that have_tag wont' test
    # note that response is depricated rails 3, use "redered" instead.
    @response_xml = REXML::Document.new(rendered)
  end

  describe "when content_format is specified" do
    describe "for an entry with content available" do
      before do
        @entry = @response_xml.elements.to_a("/feed/entry")[0]
      end
      it "should include a link rel tag" do
        expect(@entry.to_s).to have_selector("link[rel=alternate][type='application/marc']")
      end
      it "should have content embedded" do
        expect(@entry.to_s).to have_selector("content")
      end
    end
  end
end
