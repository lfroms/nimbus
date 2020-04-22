# frozen_string_literal: true
module Weather
  module Types
    class FeelsLike
      attr_reader :temperature, :type

      def initialize(temperature:, type:)
        @temperature = temperature
        @type = type
      end
    end
  end
end
