# frozen_string_literal: true
require 'geocoder/stores/active_record'

class CanadaSite < ApplicationRecord
  include Geocoder::Store::ActiveRecord

  validates :name, presence: false
  validates :code, presence: true
  validates :province, presence: true, length: { in: 2..3 }
  validates :latitude, presence: true
  validates :longitude, presence: true

  def self.geocoder_options
    { latitude: :latitude, longitude: :longitude }
  end
end
