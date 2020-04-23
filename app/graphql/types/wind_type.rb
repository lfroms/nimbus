# frozen_string_literal: true
module Types
  class WindType < Types::BaseObject
    field :speed, String, null: true
    field :gust, Float, null: true
    field :direction, String, null: true
    field :bearing, Float, null: true
  end
end
