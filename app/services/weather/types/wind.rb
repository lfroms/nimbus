# frozen_string_literal: true
module Weather
  module Types
    class Wind
      attr_reader :speed, :gust, :direction, :bearing

      def initialize(speed:, gust:, direction:, bearing:)
        @speed = speed
        @gust = gust
        @direction = direction
        @bearing = bearing
      end
    end
  end
end
