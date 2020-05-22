# frozen_string_literal: true
require 'geocoder/stores/active_record'

class Country < ApplicationRecord
  include Geocoder::Store::ActiveRecord

  # This attribute is only to be used when using the model to validate
  # a set of input parameters, typically when doing #upsert_all.
  attr_accessor :skip_uniqueness

  self.primary_key = :fips

  validates :name, presence: true
  validates :fips, presence: true, length: { is: 2 }
  validates :fips, uniqueness: true, unless: :skip_uniqueness
  validates :iso2, presence: true, length: { is: 2 }
  validates :iso3, presence: true, length: { is: 3 }
  validates :un, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :shape, presence: true

  def self.geocoder_options
    { latitude: :latitude, longitude: :longitude }
  end

  scope :nearest_to_point, -> (latitude, longitude) {
    lat = latitude.to_f.to_s
    lon = longitude.to_f.to_s

    # WARNING: Make sure that lat and lon are sanitized before passing this query!
    query = Arel.sql("ST_Distance(shape, ST_SetSRID(ST_MakePoint(#{lon},#{lat}),4326)) ASC")
    order(query).first
  }
end
