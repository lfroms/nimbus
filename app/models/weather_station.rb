# frozen_string_literal: true
class WeatherStation < ApplicationRecord
  validates :code, presence: true
  validates :name, presence: false
  validates :province, presence: true
  validates :location, presence: false

  belongs_to :country

  scope :near, -> (coordinates) {
    latitude, longitude = coordinates

    lat = latitude.to_f.to_s
    lon = longitude.to_f.to_s

    # WARNING: Make sure that lat and lon are sanitized before passing this query!
    query = Arel.sql("ST_Distance(location, ST_SetSRID(ST_MakePoint(#{lon},#{lat}),4326)) ASC")
    order(query)
  }

  def coordinate
    Weather::Types::Coordinate.new(latitude: location.y, longitude: location.x)
  end

  def distance(coordinates)
    latitude, longitude = coordinates
    point = RGeo::Geographic.spherical_factory(srid: 4326).point(longitude, latitude)

    point.distance(location) / 1000
  end
end
