# frozen_string_literal: true
module Weather
  module Types
    class Currently
      attr_reader :time,
        :summary,
        :icon,
        :temperature,
        :feels_like,
        :wind,
        :dew_point,
        :humidity,
        :pressure,
        :visibility,
        :uv_index

      def initialize(
        time:,
        summary:,
        icon:,
        temperature:,
        feels_like:,
        wind:,
        dew_point:,
        humidity:,
        pressure:,
        visibility:,
        uv_index:
      )
        @time = time
        @summary = summary
        @icon = icon
        @temperature = temperature
        @feels_like = feels_like
        @wind = wind
        @dew_point = dew_point
        @humidity = humidity
        @pressure = pressure
        @visibility = visibility
        @uv_index = uv_index
      end
    end
  end
end
