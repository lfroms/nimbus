# frozen_string_literal: true
module Weather
  module Types
    class Coordinate
      attr_reader :latitude, :longitude

      def initialize(latitude:, longitude:)
        @latitude = latitude
        @longitude = longitude
      end

      def to_a
        [latitude, longitude]
      end
    end
  end
end
