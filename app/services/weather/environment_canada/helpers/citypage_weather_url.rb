# frozen_string_literal: true
module Weather
  module EnvironmentCanada
    module Helpers
      class CitypageWeatherUrl
        attr_reader :site_code, :province

        def initialize(site_code:, province:)
          @site_code = site_code
          @province = province
        end

        def to_uri
          URI.join('https://dd.weather.gc.ca/citypage_weather/xml/', "#{province}/", filename)
        end

        private

        def filename
          "#{site_code}_e.xml"
        end
      end
    end
  end
end
