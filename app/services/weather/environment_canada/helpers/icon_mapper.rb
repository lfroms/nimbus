# frozen_string_literal: true
module Weather
  module EnvironmentCanada
    module Helpers
      class IconMapper
        def self.icon(code:)
          return nil if code.nil?

          ICON_MAPPING[code.to_i]
        end

        ICON_MAPPING = {
          0 => Types::IconStyle::CLEAR,
          1 => Types::IconStyle::MAINLY_CLEAR,
          2 => Types::IconStyle::PARTLY_CLOUDY,
          3 => Types::IconStyle::MAINLY_CLOUDY,
          4 => Types::IconStyle::MAINLY_CLOUDY,
          5 => Types::IconStyle::MAINLY_CLEAR,
          6 => Types::IconStyle::RAIN,
          7 => Types::IconStyle::RAIN,
          8 => Types::IconStyle::FLURRIES,
          9 => Types::IconStyle::RAIN,
          10 => Types::IconStyle::CLOUDY,
          11 => Types::IconStyle::RAIN,
          12 => Types::IconStyle::RAIN,
          13 => Types::IconStyle::RAIN,
          14 => Types::IconStyle::FLURRIES,
          15 => Types::IconStyle::FLURRIES,
          16 => Types::IconStyle::SNOW,
          17 => Types::IconStyle::SNOW,
          18 => Types::IconStyle::SNOW,
          19 => Types::IconStyle::THUNDERSTORM,

          22 => Types::IconStyle::MAINLY_CLEAR,
          23 => Types::IconStyle::FOG,
          24 => Types::IconStyle::FOG,
          25 => Types::IconStyle::DRIFTING_SNOW,
          26 => Types::IconStyle::ICE_CRYSTALS,
          27 => Types::IconStyle::HAIL,
          28 => Types::IconStyle::RAIN,

          30 => Types::IconStyle::CLEAR,
          31 => Types::IconStyle::MAINLY_CLEAR,
          32 => Types::IconStyle::PARTLY_CLOUDY,
          33 => Types::IconStyle::MAINLY_CLOUDY,
          34 => Types::IconStyle::MAINLY_CLOUDY,
          35 => Types::IconStyle::MAINLY_CLEAR,
          36 => Types::IconStyle::RAIN,
          37 => Types::IconStyle::FLURRIES,
          38 => Types::IconStyle::FLURRIES,
          39 => Types::IconStyle::THUNDERSTORM,
          40 => Types::IconStyle::DRIFTING_SNOW,
          41 => Types::IconStyle::FUNNEL,
          42 => Types::IconStyle::FUNNEL,
          43 => Types::IconStyle::WINDY,
          44 => Types::IconStyle::PARTICULATE,
          45 => Types::IconStyle::PARTICULATE,
          46 => Types::IconStyle::THUNDERSTORM,
          47 => Types::IconStyle::THUNDERSTORM,
          48 => Types::IconStyle::FUNNEL,
        }
      end
    end
  end
end
