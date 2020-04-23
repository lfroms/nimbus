# frozen_string_literal: true
module Types
  class CoordinateType < Types::BaseObject
    field :latitude, Float, null: false
    field :longitude, Float, null: false
  end
end
