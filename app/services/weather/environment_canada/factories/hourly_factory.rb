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

          @hourly_forecast_group.xpath('hourlyForecast').map do |forecast|
            Types::Hourly.new(
              time: time(item: forecast),
              summary: forecast.xpath('condition').first&.content&.presence,
              icon: icon(item: forecast),
              temperature: forecast.xpath('temperature').first&.content&.presence,
              feels_like: feels_like(item: forecast),
              precip_probability: forecast.xpath('lop').first&.content&.presence&.to_i&.to_percent,
              wind: wind(item: forecast)
            )
          end
        end

        private

        def time(item:)
          Time.strptime(item.get_attribute('dateTimeUTC'), '%Y%m%d%H%M').to_i
        end

        def icon(item:)
          code = item.xpath('iconCode').first&.content&.presence
          IconFactory.new(code: code).create
        end

        def feels_like(item:)
          humidex = item.xpath('humidex').first&.content&.presence
          wind_chill = item.xpath('windChill').first&.content&.presence

          if humidex.present?
            Types::FeelsLike.new(temperature: humidex, type: Types::FeelsLikeType::HUMIDEX)
          elsif wind_chill.present?
            Types::FeelsLike.new(temperature: wind_chill, type: Types::FeelsLikeType::WIND_CHILL)
          else
            Types::FeelsLike.new(temperature: nil, type: nil)
          end
        end

        def wind(item:)
          wind_node = item.xpath('wind').first

          Types::Wind.new(
            speed: wind_node&.xpath('speed')&.first&.content&.presence,
            gust: wind_node&.xpath('gust')&.first&.content&.presence,
            direction: wind_node&.xpath('direction')&.first&.content&.presence,
            bearing: wind_node&.xpath('bearing')&.first&.content&.presence
          )
        end
      end
    end
  end
end
