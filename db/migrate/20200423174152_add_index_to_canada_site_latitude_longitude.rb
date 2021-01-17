# frozen_string_literal: true
class AddIndexToCanadaSiteLatitudeLongitude < ActiveRecord::Migration[6.0]
  def change
    add_index(:canada_sites, [:latitude, :longitude])
  end
end
