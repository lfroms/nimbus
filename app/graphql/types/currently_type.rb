# frozen_string_literal: true
module Types
  class CurrentlyType < Types::BaseObject
    field :time, Float, null: false
    field :summary, String, null: true
    field :icon, Types::IconType, null: false
    field :temperature, Float, null: true
    field :feels_like, Types::FeelsLikeType, null: false
    field :wind, Types::WindType, null: false
    field :dew_point, Float, null: true
    field :humidity, Float, null: true
    field :pressure, Types::PressureType, null: false
    field :visibility, Float, null: true
    field :uv_index, Integer, null: true
    field :air_quality, Integer, null: true
  end
end
