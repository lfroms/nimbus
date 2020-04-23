# frozen_string_literal: true
module Weather
  module EnvironmentCanada
    module Factories
      class TodayFactory < Factory
        attr :forecast_group, :rise_set

        def initialize(forecast_group:, rise_set:)
          @forecast_group = forecast_group
          @rise_set = rise_set
        end

        def create
          Types::Today.new(
            high_temperature: today&.xpath('temperatures/temperature')&.first&.content&.presence,
            low_temperature: tonight&.xpath('temperatures/temperature')&.first&.content&.presence,
            sunrise_time: sunrise_time,
            sunset_time: sunset_time,
          )
        end

        private

        def today
          forecast_group&.xpath("forecast[period/@textForecastName='Today']")
        end

        def tonight
          forecast_group&.xpath("forecast[period/@textForecastName='Tonight']")
        end

        def sunrise_time
          stamp = rise_set&.xpath("dateTime[@name='sunrise' and @zone='UTC']/timeStamp")&.first&.content&.presence
          parse_timestamp(stamp)
        end

        def sunset_time
          stamp = rise_set&.xpath("dateTime[@name='sunset' and @zone='UTC']/timeStamp")&.first&.content&.presence
          parse_timestamp(stamp)
        end

        def parse_timestamp(stamp)
          return nil if stamp.nil?

          Time.strptime(stamp, '%Y%m%d%H%M%S').to_i
        end
      end
    end
  end
end
