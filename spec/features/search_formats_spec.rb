# -*- encoding : utf-8 -*-

require 'spec_helper'

describe "Search Formats" do
  before do
    # Get all the fields from Solr, so the #index documents have the MARC field (to trigger appropriate
    # export formats)
    CatalogController.blacklight_config.default_solr_params[:fl] = '*'
  end

  it "should return new-line separated RIS records" do
    visit "/catalog.endnote?q="
    expect(page.status_code).to eq 200
    rmt_regex = /^%0/
    expect(page).to have_content "%A Bstan-ʼdzin-rgya-mtsho,"
    expect(page).to have_content "%@ 9789573908678"
    expect(page.body).to match rmt_regex
    expect(page.body.scan(rmt_regex).length).to eq 10
  end

  it "should return new-line separated MARC records" do
    visit "/catalog.refworks_marc_txt?q="
    expect(page.status_code).to eq 200
    rmt_regex = /LEADER .+\n(\d\d\d .. .+\n)+/
    expect(page).to have_content "LEADER 01221cam a22002534a 4500001"
    expect(page).to have_content "LEADER 01127cam a22002895a 4500001"
    expect(page.body).to match rmt_regex
    expect(page.body.scan(rmt_regex).length).to eq 10
  end
end
