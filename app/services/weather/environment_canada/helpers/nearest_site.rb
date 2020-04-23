# frozen_string_literal: true
module Weather
  module EnvironmentCanada
    module Helpers
      class NearestSite
        class << self
          def to(coordinate:, rank: 0)
            nearest_sites = feature_collection.sort_by do |feature|
              feature_coordinates = [feature['Latitude'], feature['Longitude']]
              Geocoder::Calculations.distance_between(coordinate.to_a, feature_coordinates)
            end

            nearest_sites[rank]
          end

          private

          SITELIST_URL = 'https://collaboration.cmc.ec.gc.ca/cmc/cmos/public_doc/msc-data/citypage-weather/site_list_en.geojson'

          def feature_collection
            response = Typhoeus.get(SITELIST_URL, followlocation: true).body
            parsed_json = JSON.parse(response)
            RGeo::GeoJSON.decode(parsed_json)
          rescue => _
            []
          end
        end
      end
    end
  end
end
