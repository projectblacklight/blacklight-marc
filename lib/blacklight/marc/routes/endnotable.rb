# frozen_string_literal: true
module Blacklight
  module Marc
    module Routes
      class Endnotable
        def initialize(defaults = {})
          @defaults = defaults
        end

        def call(mapper, options = {})
          options = @defaults.merge(options)

          mapper.match 'endnote', via: :get
        end
      end
    end
  end
end