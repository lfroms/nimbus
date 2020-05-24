# frozen_string_literal: true
module Weather
  module Errors
    class UnsupportedLocationError < StandardError
      def initialize(msg = 'Weather information for your location is not yet supported')
        super
      end
    end
  end
end
