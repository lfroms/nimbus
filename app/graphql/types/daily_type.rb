# frozen_string_literal: true
module Types
  class DailyType < Types::BaseObject
    field :time, Float, null: false
    field :daytime_conditions, Types::HalfDayConditionType, null: true
    field :nighttime_conditions, Types::HalfDayConditionType, null: true
  end
end
