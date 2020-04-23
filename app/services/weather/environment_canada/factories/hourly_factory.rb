# frozen_string_literal: true
module Weather
  module EnvironmentCanada
    module Factories
      class HourlyFactory < Factory
        attr :hourly_forecast_group

        def initialize(hourly_forecast_group:)
          @hourly_forecast_group = hourly_forecast_group
        end

        def create
          return [] if @hourly_forecast_group.nil?

          @hourly_forecast_group.xpath('//hourlyForecast').map do |forecast|
            Types::Hourly.new(
              time: forecast.xpath('//dateTimeUTC').first&.content&.to_unix,
              summary: forecast.xpath('//condition').first&.content,
              icon: forecast.xpath('//iconCode').first&.content,
              temperature: forecast.xpath('//temperature').first&.content,
              feels_like: feels_like(item: forecast),
              precip_probability: forecast.xpath('//lop').first&.content&.to_i&.to_decimal_percent,
              wind: wind(item: forecast)
            )
          end
        end

        private

        def feels_like(item:)
          humidex = item.xpath('//humidex').first&.content
          wind_chill = item.xpath('//windChill').first&.content

          if humidex.present?
            Types::FeelsLike.new(temperature: humidex, type: Types::FeelsLikeType::HUMIDEX)
          elsif wind_chill.present?
            Types::FeelsLike.new(temperature: wind_chill, type: Types::FeelsLikeType::WIND_CHILL)
          else
            Types::FeelsLike.new(temperature: nil, type: nil)
          end
        end

        def wind(item:)
          wind_node = item.xpath('//wind').first

          Types::Wind.new(
            speed: wind_node&.xpath('//speed')&.first&.content,
            gust: wind_node&.xpath('//gust')&.first&.content,
            direction: wind_node&.xpath('//direction')&.first&.content,
            bearing: wind_node&.xpath('//bearing')&.first&.content
          )
        end
      end
    end
  end
end
