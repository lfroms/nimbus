# frozen_string_literal: true
module Sites
  module EnvironmentCanada
    class SiteListSyncService < UseCaseService
      SITELIST_URL = 'https://collaboration.cmc.ec.gc.ca/cmc/cmos/public_doc/msc-data/citypage-weather/site_list_en.geojson'

      def execute(_)
        CanadaSite.upsert_all(objects.compact) # rubocop:disable Rails/SkipsModelValidations
      end

      private

      def feature_collection
        response = Typhoeus.get(SITELIST_URL, followlocation: true).body
        parsed_json = JSON.parse(response)
        RGeo::GeoJSON.decode(parsed_json)
      rescue => e
        Rails.logger.error(e)
        []
      end

      def objects
        feature_collection.map do |feature|
          # https://github.com/rails/rails/issues/35493
          now = Time.zone.now

          params = {
            name: feature['English Names'],
            code: feature['Codes'],
            province: feature['Province Codes'],
            latitude: feature['Latitude'],
            longitude: feature['Longitude'],
            updated_at: now,
          }

          # Check to make sure the item we are adding is actually valid.
          if CanadaSite.new(skip_uniqueness: true, **params).valid?
            params
          end
        end
      end
    end
  end
end
