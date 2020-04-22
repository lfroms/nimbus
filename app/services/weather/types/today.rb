# frozen_string_literal: true
module Weather
  module Types
    class Today
      attr_reader :high_temperature, :low_temperature, :sunrise_time, :sunset_time

      def initialize(high_temperature:, low_temperature:, sunrise_time:, sunset_time:)
        @high_temperature = high_temperature
        @low_temperature = low_temperature
        @sunrise_time = sunrise_time
        @sunset_time = sunset_time
      end
    end
  end
end
