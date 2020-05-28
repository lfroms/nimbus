# frozen_string_literal: true
module Weather
  module NationalWeatherService
    module Factories
      class CurrentlyFactory < Factory
        attr :properties

        def initialize(properties:)
          @properties = properties
        end

        def create
          Types::Currently.new(
            time: time,
            summary: properties.dig('textDescription'),
            icon: icon,
            temperature: properties.dig('temperature', 'value'),
            feels_like: feels_like,
            wind: wind,
            dew_point: properties.dig('dewpoint', 'value'),
            humidity: properties.dig('relativeHumidity', 'value')&.to_i&.to_percent,
            pressure: pressure,
            visibility: properties.dig('visibility', 'value'),
            uv_index: nil
          )
        end

        private

        def time
          Time.iso8601(properties.dig('timestamp')).to_i
        end

        def icon
          code = 0
          Weather::EnvironmentCanada::Factories::IconFactory.new(code: code).create
        end

        def feels_like
          humidex = properties.dig('heatIndex', 'value')
          wind_chill = properties.dig('windChill', 'value')

          if humidex.present?
            Types::FeelsLike.new(temperature: humidex, type: Types::FeelsLikeType::HUMIDEX)
          elsif wind_chill.present?
            Types::FeelsLike.new(temperature: wind_chill, type: Types::FeelsLikeType::WIND_CHILL)
          else
            Types::FeelsLike.new(temperature: nil, type: nil)
          end
        end

        def wind
          Types::Wind.new(
            speed: properties.dig('windSpeed', 'value'),
            gust: properties.dig('windGust', 'value'),
            direction: nil,
            bearing: properties.dig('windDirection', 'value')
          )
        end

        def pressure
          Types::Pressure.new(
            value: properties.dig('barometricPressure', 'value').to_f / 1000,
            tendency: nil,
            change: nil
          )
        end
      end
    end
  end
end
