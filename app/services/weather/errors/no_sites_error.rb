# frozen_string_literal: true
module Weather
  module Errors
    class NoSitesError < StandardError
      def initialize(msg = 'Could not find a site within the requested region')
        super
      end
    end
  end
end
