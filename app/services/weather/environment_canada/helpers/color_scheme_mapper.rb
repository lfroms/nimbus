# frozen_string_literal: true
module Weather
  module EnvironmentCanada
    module Helpers
      class ColorSchemeMapper
        def self.color_scheme(code:)
          return Types::ColorScheme::EMPTY if code.nil?

          SCHEME_MAPPING[code.to_i] || Types::ColorScheme::EMPTY
        end

        SCHEME_MAPPING = {
          0 => Types::ColorScheme::CLEAR_SKY,
          1 => Types::ColorScheme::CLEAR_SKY,
          2 => Types::ColorScheme::CLEAR_SKY,
          3 => Types::ColorScheme::CLEAR_SKY,
          4 => Types::ColorScheme::CLEAR_SKY,
          5 => Types::ColorScheme::CLEAR_SKY,
          6 => Types::ColorScheme::DRY_CLOUD,
          7 => Types::ColorScheme::DRY_CLOUD,
          8 => Types::ColorScheme::DRY_CLOUD,
          9 => Types::ColorScheme::WET_CLOUD,
          10 => Types::ColorScheme::DRY_CLOUD,
          11 => Types::ColorScheme::WET_CLOUD,
          12 => Types::ColorScheme::WET_CLOUD,
          13 => Types::ColorScheme::WET_CLOUD,
          14 => Types::ColorScheme::WET_CLOUD,
          15 => Types::ColorScheme::WET_CLOUD,
          16 => Types::ColorScheme::DRY_CLOUD,
          17 => Types::ColorScheme::DRY_CLOUD,
          18 => Types::ColorScheme::WET_CLOUD,
          19 => Types::ColorScheme::STORM,

          22 => Types::ColorScheme::CLEAR_SKY,
          23 => Types::ColorScheme::DRY_CLOUD,
          24 => Types::ColorScheme::DRY_CLOUD,
          25 => Types::ColorScheme::DRY_CLOUD,
          26 => Types::ColorScheme::DRY_CLOUD,
          27 => Types::ColorScheme::DRY_CLOUD,
          28 => Types::ColorScheme::DRY_CLOUD,

          30 => Types::ColorScheme::NIGHT,
          31 => Types::ColorScheme::NIGHT,
          32 => Types::ColorScheme::NIGHT,
          33 => Types::ColorScheme::NIGHT,
          34 => Types::ColorScheme::NIGHT,
          35 => Types::ColorScheme::NIGHT,
          36 => Types::ColorScheme::NIGHT,
          37 => Types::ColorScheme::NIGHT,
          38 => Types::ColorScheme::NIGHT,
          39 => Types::ColorScheme::NIGHT,
          40 => Types::ColorScheme::DRY_CLOUD,
          41 => Types::ColorScheme::STORM,
          42 => Types::ColorScheme::STORM,
          43 => Types::ColorScheme::DRY_CLOUD,
          44 => Types::ColorScheme::PARTICULATE,
          45 => Types::ColorScheme::PARTICULATE,
          46 => Types::ColorScheme::STORM,
          47 => Types::ColorScheme::PARTICULATE,
          48 => Types::ColorScheme::LIQUID,
        }
      end
    end
  end
end
