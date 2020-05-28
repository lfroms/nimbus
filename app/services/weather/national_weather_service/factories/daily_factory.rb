# frozen_string_literal: true
module Weather
  module NationalWeatherService
    module Factories
      class DailyFactory < Factory
        attr :forecast

        def initialize(forecast:)
          @forecast = forecast
        end

        def create
          input = periods
          return [] if forecast.nil? || input.nil? || input.empty?

          # Day condition should be nil if first item is night.
          input.unshift(nil) if night?(input.first)

          input.each_slice(2).each_with_index.map do |pair, index|
            day, night = pair

            Types::Daily.new(
              time: time(index: index),
              daytime_conditions: half_day_condition(period: day),
              nighttime_conditions: half_day_condition(period: night)
            )
          end
        end

        private

        def periods
          forecast['periods']
        end

        def forecast_issue_date
          Time.iso8601(forecast.dig('updateTime'))
        end

        def time(index:)
          today = Time.zone.today
          yesterday = Time.zone.yesterday

          starts_yesterday = forecast_issue_date.beginning_of_day == yesterday
          start_date = starts_yesterday ? yesterday : today

          (start_date + index.day).to_time.to_i
        end

        def half_day_condition(period:)
          return nil if period.nil?

          Types::HalfDayCondition.new(
            summary_extended: period['detailedForecast'],
            summary_clouds: nil,
            summary: period['shortForecast'],
            icon: icon(item: period),
            temperature: period['temperature'],
            humidity: nil,
            feels_like: feels_like(item: period),
            precip_probability: nil,
            wind: wind(item: period)
          )
        end

        def icon(item:)
          Weather::EnvironmentCanada::Factories::IconFactory.new(code: 1).create
        end

        def wind(item:)
          Types::Wind.new(
            speed: item['windSpeed'],
            gust: nil,
            direction: item['windDirection'],
            bearing: nil
          )
        end

        def feels_like(item:)
          Types::FeelsLike.new(temperature: nil, type: nil)
        end

        def night?(period)
          period['isDaytime'] == false
        end
      end
    end
  end
end
