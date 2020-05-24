# frozen_string_literal: true
class Country < ApplicationRecord
  # This attribute is only to be used when using the model to validate
  # a set of input parameters, typically when doing #upsert_all.
  attr_accessor :skip_uniqueness

  validates :name, presence: true
  validates :fips, presence: true, length: { is: 2 }
  validates :fips, uniqueness: true, unless: :skip_uniqueness
  validates :iso2, presence: true, length: { is: 2 }
  validates :iso3, presence: true, length: { is: 3 }
  validates :un, presence: true
  validates :location, presence: true
  validates :shape, presence: true

  has_many :weather_stations, dependent: :destroy

  scope :nearest_to_point, -> (latitude, longitude) {
    lat = latitude.to_f.to_s
    lon = longitude.to_f.to_s

    # WARNING: Make sure that lat and lon are sanitized before passing this query!
    query = Arel.sql("ST_Distance(shape, ST_SetSRID(ST_MakePoint(#{lon},#{lat}),4326)) ASC")
    order(query).first
  }
end
