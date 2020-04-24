# frozen_string_literal: true
module Types
  class ColorSchemeType < Types::BaseEnum
    value 'clearSky'
    value 'dryCloud'
    value 'wetCloud'
    value 'storm'
    value 'night'
    value 'particulate'
    value 'liquid'
    value 'empty'
  end
end
