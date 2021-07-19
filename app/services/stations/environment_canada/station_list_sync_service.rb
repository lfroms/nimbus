# frozen_string_literal: true
module Stations
  module EnvironmentCanada
    class StationListSyncService < UseCaseService
      STATION_LIST_URL = 'https://collaboration.cmc.ec.gc.ca/cmc/cmos/public_doc/msc-data/citypage-weather/site_list_en.geojson'

      def execute(_)
        country.weather_stations.upsert_all(objects, unique_by: :code) # rubocop:disable Rails/SkipsModelValidations
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
        @country ||= Country.find_by(fips: 'CA')
      end

      def objects
        feature_collection.map do |feature|
          # https://github.com/rails/rails/issues/35493
          now = Time.zone.now

          latitude = feature['Latitude']
          longitude = feature['Longitude']
          point = "POINT(#{longitude} #{latitude})"

          {
            code: feature['Codes'],
            name: feature['English Names'],
            province: feature['Province Codes'],
            location: point,
            country_id: country.id,
            updated_at: now,
          }
        end
      end
    end
  end
end
