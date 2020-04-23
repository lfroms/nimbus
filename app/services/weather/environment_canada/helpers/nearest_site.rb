# frozen_string_literal: true
module Weather
  module EnvironmentCanada
    module Helpers
      class NearestSite
        attr_reader :site_code, :name, :province, :coordinate

        SITELIST_URL = 'https://collaboration.cmc.ec.gc.ca/cmc/cmos/public_doc/msc-data/citypage-weather/site_list_en.geojson'

        def initialize(site_code:, name:, province:, coordinate:)
          @site_code = site_code
          @name = name
          @province = province
          @coordinate = coordinate
        end

        class << self
          def to(coordinate:, rank: 0)
            nearest_site = sorted_by_distance_relative_to(coordinate: coordinate)[rank]

            from(feature: nearest_site)
          end

          def top(number, coordinate:)
            nearest_sites = sorted_by_distance_relative_to(coordinate: coordinate).first(number)

            nearest_sites.map do |feature|
              from(feature: feature)
            end
          end

          def from(feature:)
            new(
              site_code: feature['Codes'],
              name: feature['English Names'],
              province: feature['Province Codes'],
              coordinate: Types::Coordinate.new(
                latitude: feature['Latitude'],
                 longitude: feature['Longitude']
              )
            )
          end

          private

          def sorted_by_distance_relative_to(coordinate:)
            feature_collection.sort_by do |feature|
              feature_coordinates = [feature['Latitude'], feature['Longitude']]
              Geocoder::Calculations.distance_between(coordinate.to_a, feature_coordinates)
            end
          end

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
