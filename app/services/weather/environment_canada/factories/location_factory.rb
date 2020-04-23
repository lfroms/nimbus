# frozen_string_literal: true
module Weather
  module EnvironmentCanada
    module Factories
      class LocationFactory < Factory
        attr :location, :current_conditions, :station_coordinate

        def initialize(location:, current_conditions:, station_coordinate:)
          @location = location
          @current_conditions = current_conditions
          @station_coordinate = station_coordinate
        end

        def create
          Types::Location.new(
            region_name: @location&.xpath('name')&.first&.content,
            station_name: @current_conditions&.xpath('station')&.first&.content,
            country: @location&.xpath('country')&.first&.content,
            coordinate: @station_coordinate
          )
        end
      end
    end
  end
end
