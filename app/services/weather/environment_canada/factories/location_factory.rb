# frozen_string_literal: true
module Weather
  module EnvironmentCanada
    module Factories
      class LocationFactory < Factory
        attr :location, :current_conditions, :station_coordinate

        def initialize(location:, current_conditions:, station_coordinate:)
          super
          @location = location
          @current_conditions = current_conditions
          @station_coordinate = station_coordinate
        end

        def create
          Types::Location.new(
            region_name: @location&.xpath('name')&.first&.content&.presence,
            station_name: @current_conditions&.xpath('station')&.first&.content&.presence,
            country: @location&.xpath('country')&.first&.content&.presence,
            coordinate: @station_coordinate
          )
        end
      end
    end
  end
end
