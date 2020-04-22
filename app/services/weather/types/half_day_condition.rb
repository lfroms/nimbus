# frozen_string_literal: true
module Weather
  module Types
    class HalfDayCondition
      attr_reader :summary_extended,
        :summary_clouds,
        :summary,
        :icon,
        :temperature,
        :humidity,
        :feels_like,
        :precip_probability,
        :wind

      def initialize(
        summary_extended:,
        summary_clouds:,
        summary:,
        icon:,
        temperature:,
        humidity:,
        feels_like:,
        precip_probability:,
        wind:
      )
        @summary_extended = summary_extended
        @summary_clouds = summary_clouds
        @summary = summary
        @icon = icon
        @temperature = temperature
        @humidity = humidity
        @feels_like = feels_like
        @precip_probability = precip_probability
        @wind = wind
      end
    end
  end
end
