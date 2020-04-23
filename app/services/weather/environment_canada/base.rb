# frozen_string_literal: true
module Weather
  module EnvironmentCanada
    class Base < Weather::Base
      attr :station_coordinate

      def location
        factory = Factories::LocationFactory.new(
          location: data.xpath('//location'),
           current_conditions: data.xpath('//currentConditions'),
           station_coordinate: station_coordinate,
        )

        factory.create
      end

      def today
        factory = Factories::TodayFactory.new(
          forecast_group: data.xpath('//forecastGroup'),
          rise_set: data.xpath('//riseSet')
        )

        factory.create
      end

      def currently
        factory = Factories::CurrentlyFactory.new(
          current_conditions: data.xpath('//currentConditions')
        )

        factory.create
      end

      def hourly
        factory = Factories::HourlyFactory.new(
          hourly_forecast_group: data.xpath('//hourlyForecastGroup')
        )

        factory.create
      end

      def daily
        factory = Factories::DailyFactory.new(
          forecast_group: data.xpath('//forecastGroup')
        )

        factory.create
      end

      def alerts
        factory = Factories::AlertsFactory.new(
          warnings: data.xpath('//warnings')
        )

        factory.create
      end

      private

      def data
        @data ||= server_data
      end

      def server_data
        xml, station_coordinate = Helpers::WeatherGetter.new(coordinate: coordinate).get
        @station_coordinate = station_coordinate

        xml
      end
    end
  end
end
