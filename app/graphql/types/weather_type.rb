# frozen_string_literal: true
module Types
  class WeatherType < Types::BaseObject
    field :location, Types::LocationType, null: false
    field :today, Types::TodayType, null: false
    field :currently, Types::CurrentlyType, null: false
    field :hourly, [Types::HourlyType], null: false
    field :daily, [Types::DailyType], null: false
    field :alerts, [Types::AlertType], null: false
  end
end
