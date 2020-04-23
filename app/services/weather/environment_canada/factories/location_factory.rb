# frozen_string_literal: true
module Weather
  module EnvironmentCanada
    module Factories
      class LocationFactory < Factory
        attr :location, :current_conditions, :station_coordinate, :user_coordinate

        def initialize(location:, current_conditions:, station_coordinate:, user_coordinate:)
          @location = location
          @current_conditions = current_conditions
          @station_coordinate = station_coordinate
          @user_coordinate = user_coordinate
        end

        def create
          Types::Location.new(
            region_name: @location&.xpath('//name')&.first&.content,
            station_name: @current_conditions&.xpath('//station')&.first&.content,
            country: @location&.xpath('//country')&.first&.content,
            coordinate: @station_coordinate,
            distance: distance
          )
        end

        private

        def distance
          return 0 if @station_coordinate.nil? || @user_coordinate.nil?

          factory = RGeo::Geographic.spherical_factoriy

          first_point = factory.point(@station_coordinate.longitude, @station_coordinate.latitude)
          second_point = factory.point(@user_coordinate.longitude, @user_coordinate.latitude)

          first_point.distance(second_point)
        end
      end
    end
  end
end
