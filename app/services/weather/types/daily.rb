# frozen_string_literal: true
module Weather
  module Types
    class Daily
      attr_reader :time, :daytime_conditions, :nighttime_conditions

      def initialize(time:, daytime_conditions:, nighttime_conditions:)
        @time = time
        @daytime_conditions = daytime_conditions
        @nighttime_conditions = nighttime_conditions
      end
    end
  end
end
