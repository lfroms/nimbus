# frozen_string_literal: true
module Weather
  module EnvironmentCanada
    module Helpers
      class WeatherGetter
        attr :coordinate

        def initialize(coordinate:)
          @coordinate = coordinate
        end

        def get
          raise Weather::Errors::NoSitesError if closest_site.nil? && second_closest_site.nil?

          main_site_data = primary_data
          main_site_result = [main_site_data, closest_site.coordinate]

          return main_site_result if observing?(main_site_data)

          unless can_use_secondary?
            raise Weather::Errors::NoDataError if main_site_data.nil?
            return main_site_result
          end

          backup_site_data = secondary_data
          return [backup_site_data, second_closest_site.coordinate] if observing?(backup_site_data)

          raise Weather::Errors::NoDataError if main_site_data.nil?
          main_site_result
        end

        private

        def fetch_data(url)
          response = Typhoeus.get(url, followlocation: true, cache_ttl: 120).body
          Nokogiri::XML(response)
        rescue
          # Return a blank XML document
          Nokogiri::XML('')
        end

        def primary_data
          fetch_data(closest_url)
        end

        def secondary_data
          fetch_data(second_closest_url)
        end

        def nearby_sites
          @nearby_sites ||= CanadaSite.near(coordinate.to_a, 500).first(2) # Within 500km
        end

        def closest_site
          nearby_sites.first
        end

        def second_closest_site
          nearby_sites.last
        end

        def closest_url
          url_for_site(closest_site)
        end

        def second_closest_url
          url_for_site(second_closest_site)
        end

        def can_use_secondary?
          closest_site.distance_from(coordinate.to_a) <= 30
        end

        def url_for_site(site)
          CitypageWeatherUrl.new(site_code: site.code, province: site.province).to_uri
        end

        def observing?(xml_site_data)
          xml_site_data&.xpath('//currentConditions/iconCode')&.first&.content&.presence&.present? || false
        end
      end
    end
  end
end
