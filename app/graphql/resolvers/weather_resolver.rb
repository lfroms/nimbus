# frozen_string_literal: true
module Resolvers
  class WeatherResolver < Resolvers::Base
    type Types::WeatherType, null: true

    argument :latitude, Float, required: true
    argument :longitude, Float, required: true

    def resolve(latitude:, longitude:)
      coordinate = Weather::Types::Coordinate.new(latitude: latitude, longitude: longitude)
      Weather::EnvironmentCanada::Base.new(coordinate: coordinate)
    end
  end
end
