# frozen_string_literal: true
class WeatherStation < ApplicationRecord
  validates :code, presence: true
  validates :name, presence: false
  validates :province, presence: true
  validates :location, presence: false

  belongs_to :country

  scope :within, -> (radius:, of:) {
    latitude, longitude = of

    sanitized_latitude = latitude.to_f.to_s
    sanitized_longitude = longitude.to_f.to_s

    # WARNING: Make sure that sanitized_latitude and sanitized_longitude are sanitized before passing this query!
    point = "ST_SetSRID(ST_MakePoint(#{sanitized_longitude},#{sanitized_latitude}), #{SRID})"
    distance_query = Arel.sql("ST_Distance(location, #{point}) ASC")

    where("ST_DWithin(location, #{point}, ?)", radius)
      .order(distance_query)
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
