# frozen_string_literal: true
module Stations
  module NationalWeatherService
    class StationListSyncService < UseCaseService
      STATION_LIST_URL = 'https://api.weather.gov/stations'

      def execute(_)
        country.weather_stations.upsert_all(objects.compact, unique_by: :code) # rubocop:disable Rails/SkipsModelValidations, Layout/LineLength
      end

      private

      def feature_collection
        response = Typhoeus.get(STATION_LIST_URL, followlocation: true).body
        parsed_json = JSON.parse(response)
        RGeo::GeoJSON.decode(parsed_json)
      rescue => e
        Rails.logger.error(e)
        []
      end

      def country
        @country ||= Country.find_by(fips: 'US')
      end

      def objects
        feature_collection.map do |feature|
          # https://github.com/rails/rails/issues/35493
          now = Time.zone.now

          latitude = feature.geometry.coordinates.last
          longitude = feature.geometry.coordinates.first
          point = "POINT(#{longitude} #{latitude})"

          {
            name: feature['name'],
            code: feature['stationIdentifier'],
            location: point,
            country_id: country.id,
            updated_at: now,
          }
        end
      end
    end
  end
end
