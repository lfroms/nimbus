# frozen_string_literal: true
module Weather
  module Types
    class Pressure
      attr_reader :value, :tendency, :change

      def initialize(value:, tendency:, change:)
        @value = value
        @tendency = tendency
        @change = change
      end
    end
  end
end
