# frozen_string_literal: true
require 'geocoder/stores/active_record'

class CanadaSite < ApplicationRecord
  include Geocoder::Store::ActiveRecord

  # This attribute is only to be used when using the model to validate
  # a set of input parameters, typically when doing #upsert_all.
  attr_accessor :skip_uniqueness

  self.primary_key = :code

  validates :name, presence: false
  validates :code, presence: true
  validates :code, uniqueness: true, unless: :skip_uniqueness
  validates :province, presence: true, length: { in: 2..3 }
  validates :latitude, presence: true
  validates :longitude, presence: true

  def self.geocoder_options
    { latitude: :latitude, longitude: :longitude }
  end
end
