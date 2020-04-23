# frozen_string_literal: true
module Weather
  module Types
    class Location
      attr_reader :region_name, :station_name, :country, :coordinate

      def initialize(region_name:, station_name:, country:, coordinate:)
        @region_name = region_name
        @station_name = station_name
        @country = country
        @coordinate = coordinate
      end
    end
  end
end
