# frozen_string_literal: true
module Types
  class LocationType < Types::BaseObject
    field :region_name, String, null: true
    field :station_name, String, null: true
    field :country, String, null: true
    field :coordinate, Types::CoordinateType, null: false
  end
end
