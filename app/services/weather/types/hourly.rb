# frozen_string_literal: true
module Weather
  module Types
    class Hourly
      attr_reader :time, :summary, :icon, :temperature, :feels_like, :precip_probability, :wind

      def initialize(time:, summary:, icon:, temperature:, feels_like:, precip_probability:, wind:)
        @time = time
        @summary = summary
        @icon = icon
        @temperature = temperature
        @feels_like = feels_like
        @precip_probability = precip_probability
        @wind = wind
      end
    end
  end
end
