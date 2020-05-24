# frozen_string_literal: true
module Resolvers
  class WeatherResolver < Resolvers::Base
    type Types::WeatherType, null: true

    argument :latitude, Float, required: true
    argument :longitude, Float, required: true

    def resolve(latitude:, longitude:)
      country = Country.nearest_to_point(latitude, longitude)
      coordinate = Weather::Types::Coordinate.new(latitude: latitude, longitude: longitude)

      case country.fips
      when 'CA'
        Weather::EnvironmentCanada::Base.new(coordinate: coordinate)
      else
        raise Weather::Errors::UnsupportedLocationError
      end
    end
  end
end
