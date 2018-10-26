# -*- encoding : utf-8 -*-
require 'spec_helper'

describe CatalogController do
  before do
    SolrDocument.use_extension( Blacklight::Solr::Document::Marc )
  end
  describe "endnote" do
    render_views
    it "should render endnote" do
      get :show, params: { id: '86207417', format: 'endnote' }
      expect(response.body).to eq "%0 Generic
%A Finkel, Chaim Jacob. 
%C Yerushalayim : 
%D c1984. 
%I Devir, 
%@ 9650101373 
%T Shodede-yam Yehudiyim : sipurim mafliʼim ha-mevusasim ʻal ʻuvdot hisṭoriyot /\n"
    end
  end

  describe "#librarian_view" do
    it "is successful" do
      get :librarian_view, params: { id: '86207417' }
      expect(response).to be_success
    end
  end
end
