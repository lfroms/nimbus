# frozen_string_literal: true
module Weather
  module NationalWeatherService
    module Factories
      class HourlyFactory < Factory
        attr :forecast

        def initialize(forecast:)
          @forecast = forecast
        end

        def create
          return [] if @forecast.nil?

          forecast.fetch('periods', []).map do |period|
            Types::Hourly.new(
              time: time(item: period),
              summary: period['shortForecast'],
              icon: icon(item: period),
              temperature: period['temperature'],
              feels_like: feels_like(item: period),
              precip_probability: nil,
              wind: wind(item: period)
            )
          end.first(24)
        end

        private

        def time(item:)
          Time.iso8601(item.dig('startTime'))&.to_i
        end

        def icon(item:)
          Weather::EnvironmentCanada::Factories::IconFactory.new(code: 0).create
        end

        def feels_like(item:)
          Types::FeelsLike.new(temperature: nil, type: nil)
        end

        def wind(item:)
          Types::Wind.new(
            speed: item['windSpeed'],
            gust: nil,
            direction: item['windDirection'],
            bearing: nil
          )
        end
      end
    end
  end
end
