# frozen_string_literal: true
module Radar
  module EnvironmentCanada
    class Base < Radar::Base
      TIMESTAMPS_URL = 'https://geo.weather.gc.ca/geomet'

      def timestamps
        time = start_time
        output = []

        while time <= end_time
          output.append(time.to_i)
          time += interval
        end

        output
      end

      private

      def start_time
        Time.iso8601(dimension_parts.first)
      end

      def end_time
        Time.iso8601(dimension_parts.second)
      end

      def interval
        ActiveSupport::Duration.parse(dimension_parts.last)
      end

      def dimension_parts
        dimension.split('/')
      end

      def dimension
        @dimension ||= data.xpath('//xmlns:Dimension').first.content
      end

      def params
        {
          lang: 'en',
          service: 'WMS',
          request: 'GetCapabilities',
          version: '1.3.0',
          layers: 'RADAR_1KM_RRAI',
        }
      end

      def data
        @data ||= server_data
      end

      def server_data
        response = Typhoeus.get(TIMESTAMPS_URL, followlocation: true, cache_ttl: 20, params: params)

        if response.code == 200
          Nokogiri::XML(response.body)
        end
      end
    end
  end
end
