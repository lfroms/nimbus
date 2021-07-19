# frozen_string_literal: true
class CreateCountries < ActiveRecord::Migration[6.0]
  def change
    create_table(:countries) do |t|
      t.string(:name, null: false)
      t.string(:fips, null: false)
      t.string(:iso2, null: false)
      t.string(:iso3, null: false)
      t.integer(:un, null: false)
      t.st_point(:location, geographic: true)
      t.multi_polygon(:shape, srid: 4326, null: false)

      t.timestamps(default: -> { 'CURRENT_TIMESTAMP' })

      t.index(:fips, unique: true)
      t.index(:location, using: :gist)
      t.index(:shape, using: :gist)
    end
  end
end
