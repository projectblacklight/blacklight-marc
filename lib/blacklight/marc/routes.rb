# -*- encoding : utf-8 -*-
module Blacklight::Marc
  class Routes

    def initialize(router, options)
      @router = router
      @options = options
    end

    def draw
      route_sets.each do |r|
        self.send(r)
      end
    end

    protected

    def add_routes &blk
      @router.instance_exec(@options, &blk)
    end

    def route_sets
      (@options[:only] || default_route_sets) - (@options[:except] || [])
    end

    def default_route_sets
      [:catalog]
    end

    module RouteSets
      def catalog
        add_routes do |options|
          # Catalog stuff.
          get 'catalog/:id/librarian_view', :to => "catalog#librarian_view", :as => "librarian_view_solr_document"
          get "catalog/endnote", :as => "endnote_solr_document"

        end
      end
   end

  include RouteSets
  end
end
