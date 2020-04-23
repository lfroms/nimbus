# frozen_string_literal: true
module Weather
  module EnvironmentCanada
    class Base < Weather::Base
      attr :province, :site_code, :station_coordinate, :user_coordinate

      def initialize(province:, site_code:, station_coordinate:, user_coordinate:)
        @province = province
        @site_code = site_code
        @station_coordinate = station_coordinate
        @user_coordinate = user_coordinate
      end

      def location
        factory = Factories::LocationFactory.new(
          location: data.xpath('//location'),
           current_conditions: data.xpath('//currentConditions'),
           station_coordinate: @station_coordinate,
           user_coordinate: @user_coordinate
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
        @data ||= Nokogiri::XML(server_data)
      end

      def server_data
        citypage_uri = Helpers::CitypageWeatherUrl.new(site_code: site_code, province: province).to_uri

        Typhoeus.get(citypage_uri.to_s, followlocation: true).body
      end
    end
  end
end
