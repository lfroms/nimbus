# frozen_string_literal: true
module Weather
  module NationalWeatherService
    module Factories
      class TodayFactory < Factory
        attr :forecast

        def initialize(forecast:)
          @forecast = forecast
        end

        def create
          Types::Today.new(
            high_temperature: today&.fetch('temperature'),
            low_temperature: tonight&.fetch('temperature'),
            sunrise_time: nil,
            sunset_time: nil,
          )
        end

        private

        def today
          forecast.fetch('periods').select do |period|
            period['name'] == 'This Afternoon'
          end.first
        end

        def tonight
          forecast.fetch('periods').select do |period|
            period['name'] == 'Tonight'
          end.first
        end
      end
    end
  end
end
