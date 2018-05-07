# -*- encoding : utf-8 -*-
require 'spec_helper'

describe CatalogController do
  describe "endnote" do
    before do
      SolrDocument.use_extension( Blacklight::Solr::Document::Marc )
    end
    render_views
    it "should render endnote" do
      get :endnote, params: { id: '86207417', format: 'endnote' }
      expect(response.body).to eq "%0 Generic
%A Finkel, Chaim Jacob. 
%C Yerushalayim : 
%D c1984. 
%I Devir, 
%@ 9650101373 
%T Shodede-yam Yehudiyim : sipurim mafliʼim ha-mevusasim ʻal ʻuvdot hisṭoriyot /\n\n\n"
    end
  end


end
