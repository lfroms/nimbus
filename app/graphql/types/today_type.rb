# frozen_string_literal: true
module Types
  class TodayType < Types::BaseObject
    field :high_temperature, Float, null: true
    field :low_temperature, Float, null: true
    field :sunrise_time, Float, null: true
    field :sunset_time, Float, null: true
  end
end
