# frozen_string_literal: true
module Weather
  module NationalWeatherService
    module Factories
      class LocationFactory < Factory
        attr :weather_station

        def initialize(weather_station:)
          @weather_station = weather_station
        end

        def create
          Types::Location.new(
            region_name: nil,
            station_name: weather_station.name,
            country: weather_station.country.name,
            coordinate: weather_station.coordinate
          )
        end
      end
    end
  end
end
