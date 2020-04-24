# frozen_string_literal: true
module Types
  class IconType < Types::BaseObject
    field :style, Types::IconStyleType, null: true
    field :color_scheme, Types::ColorSchemeType, null: false
  end
end
