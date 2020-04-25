# frozen_string_literal: true
module Radar
  module Rainviewer
    class Base < Radar::Base
      TIMESTAMPS_URL = 'https://api.rainviewer.com/public/maps.json'

      def timestamps
        data
      end

      private

      def data
        response = Typhoeus.get(TIMESTAMPS_URL, followlocation: true, cache_ttl: 20)

        if response.code == 200
          JSON.parse(response.body)
        end
      end
    end
  end
end
