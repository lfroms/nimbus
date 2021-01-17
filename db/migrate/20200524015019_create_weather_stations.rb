# frozen_string_literal: true
class CreateWeatherStations < ActiveRecord::Migration[6.0]
  def change
    create_table(:weather_stations) do |t|
      t.string(:code, null: false)
      t.string(:name, null: true)
      t.string(:province, null: true)
      t.st_point(:location, geographic: true)

      t.references(:country, null: false, foreign_key: true)

      t.timestamps(default: -> { 'CURRENT_TIMESTAMP' })

      t.index(:code, unique: true)
      t.index(:location, using: :gist)
    end
  end
end
