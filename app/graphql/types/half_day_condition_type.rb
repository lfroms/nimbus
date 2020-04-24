# frozen_string_literal: true
module Types
  class HalfDayConditionType < Types::BaseObject
    field :summary_extended, String, null: true
    field :summary_clouds, String, null: true
    field :summary, String, null: true
    field :icon, Types::IconType, null: false
    field :temperature, Float, null: true
    field :humidity, Float, null: true
    field :feels_like, Types::FeelsLikeType, null: false
    field :precip_probability, Float, null: true
    field :wind, Types::WindType, null: false
  end
end
