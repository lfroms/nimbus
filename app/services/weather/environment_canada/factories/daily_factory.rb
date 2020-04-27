# frozen_string_literal: true
module Weather
  module EnvironmentCanada
    module Factories
      class DailyFactory < Factory
        attr :forecast_group

        def initialize(forecast_group:)
          @forecast_group = forecast_group
        end

        def create
          input = forecasts
          return [] if @forecast_group.nil? || input.nil? || input.empty?

          # Day condition should be nil if first item is night.
          input.unshift(nil) if night?(input.first)

          input.each_slice(2).each_with_index.map do |pair, index|
            day, night = pair

            Types::Daily.new(
              time: time(index: index),
              daytime_conditions: half_day_condition(forecast: day),
              nighttime_conditions: half_day_condition(forecast: night)
            )
          end
        end

        private

        def forecasts
          @forecast_group&.xpath('forecast')&.to_a
        end

        def forecast_issue_date
          @forecast_group.xpath("dateTime[@name='forecastIssue' and @zone='UTC']/timeStamp").first&.content&.to_date
        end

        def time(index:)
          today = Time.zone.today
          yesterday = Time.zone.yesterday

          starts_yesterday = forecast_issue_date.beginning_of_day == yesterday
          start_date = starts_yesterday ? yesterday : today

          (start_date + index.day).to_time.to_i
        end

        def half_day_condition(forecast:)
          return nil if forecast.nil?

          Types::HalfDayCondition.new(
            summary_extended: forecast.xpath('textSummary').first&.content&.presence,
            summary_clouds: forecast.xpath('cloudPrecip/textSummary').first&.content&.presence,
            summary: forecast.xpath('abbreviatedForecast/textSummary').first&.content&.presence,
            icon: icon(item: forecast),
            temperature: forecast.xpath('temperatures/temperature').first&.content&.presence,
            humidity: forecast.xpath('relativeHumidity').first&.content&.presence&.to_i&.to_percent,
            feels_like: feels_like(item: forecast),
            precip_probability: forecast.xpath('abbreviatedForecast/pop').first&.content&.presence&.to_i&.to_percent,
            wind: wind(item: forecast)
          )
        end

        def icon(item:)
          code = item.xpath('abbreviatedForecast/iconCode').first&.content&.presence
          IconFactory.new(code: code).create
        end

        def feels_like(item:)
          humidex = item.xpath('humidex/calculated').first&.content&.presence
          wind_chill = item.xpath('windChill/calculated').first&.content&.presence

          if humidex.present?
            Types::FeelsLike.new(temperature: humidex, type: Types::FeelsLikeType::HUMIDEX)
          elsif wind_chill.present?
            Types::FeelsLike.new(temperature: wind_chill, type: Types::FeelsLikeType::WIND_CHILL)
          else
            Types::FeelsLike.new(temperature: nil, type: nil)
          end
        end

        def wind(item:)
          wind_node = item.xpath('winds/wind').first

          Types::Wind.new(
            speed: wind_node&.xpath('speed')&.first&.content&.presence,
            gust: wind_node&.xpath('gust')&.first&.content&.presence,
            direction: wind_node&.xpath('direction')&.first&.content&.presence,
            bearing: wind_node&.xpath('bearing')&.first&.content&.presence
          )
        end

        def night?(forecast)
          forecast.xpath("period[contains(text(), 'night')]").present?
        end
      end
    end
  end
end
