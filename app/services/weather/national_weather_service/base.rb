# frozen_string_literal: true
module Weather
  module NationalWeatherService
    class Base < Weather::Base
      attr :station_coordinate

      def location
        factory = Factories::LocationFactory.new(weather_station: station)
        factory.create
      end

      def today
        factory = Factories::TodayFactory.new(
          forecast: forecast_data.properties
        )

        factory.create
      end

      def currently
        factory = Factories::CurrentlyFactory.new(
          properties: observations.properties
        )

        factory.create
      end

      def hourly
        factory = Factories::HourlyFactory.new(
          forecast: hourly_forecast_data.properties
        )

        factory.create
      end

      def daily
        factory = Factories::DailyFactory.new(
          forecast: forecast_data.properties
        )

        factory.create
      end

      def alerts
        factory = Factories::AlertsFactory.new(
          alerts: alerts_data(state: data.properties.dig('relativeLocation', 'properties', 'state'))
        )

        factory.create
      end

      # private

      def observations
        @observations ||= geojson_response("https://api.weather.gov/stations/#{station.code}/observations/latest")
      end

      def station
        @station ||= WeatherStation.near(coordinate.to_a).first
      end

      def data
        @data ||= geojson_response("https://api.weather.gov/points/#{coordinate.latitude},#{coordinate.longitude}")
      end

      def forecast_data
        @forecast_data ||= geojson_response(data.properties.dig('forecast'))
      end

      def hourly_forecast_data
        @hourly_forecast_data ||= geojson_response(data.properties.dig('forecastHourly'))
      end

      def alerts_data(state:)
        @alerts_data ||= geojson_response("https://api.weather.gov/alerts?area=#{state}&active=true")
      end

      def geojson_response(url)
        response = Typhoeus.get(url, followlocation: true, cache_ttl: 120).body
        parsed_json = JSON.parse(response)

        RGeo::GeoJSON.decode(parsed_json)
      end
    end
  end
end
