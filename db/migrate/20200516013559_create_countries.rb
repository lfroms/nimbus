class CreateCountries < ActiveRecord::Migration[6.0]
  def change
    create_table :countries, id: false do |t|
      t.string :name, null: false
      t.string :fips, null: false
      t.string :iso2, null: false
      t.string :iso3, null: false
      t.integer :un, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.multi_polygon :shape, srid: 4326, null: false

      t.timestamps default: -> { 'CURRENT_TIMESTAMP' }

      t.index :fips, unique: true
      t.index [:latitude, :longitude]
      t.index :shape, using: :gist
    end
  end
end
