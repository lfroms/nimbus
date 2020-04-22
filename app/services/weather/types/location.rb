# frozen_string_literal: true
module Weather
  module Types
    class Location
      attr_reader :region_name, :station_name, :country, :coordinate, :distance

      def initialize(region_name:, station_name:, country:, coordinate:, distance:)
        @region_name = region_name
        @station_name = station_name
        @country = country
        @coordinate = coordinate
        @distance = distance
      end
    end
  end
end
