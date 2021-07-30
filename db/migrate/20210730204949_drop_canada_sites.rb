# frozen_string_literal: true
class DropCanadaSites < ActiveRecord::Migration[6.0]
  def change
    drop_table(:canada_sites, id: false) do |t|
      t.string(:name, null: true)
      t.string(:code, null: false)
      t.string(:province, null: false)
      t.float(:latitude, null: false)
      t.float(:longitude, null: false)

      t.timestamps(default: -> { 'CURRENT_TIMESTAMP' })

      t.index(:code, unique: true)
      t.index([:latitude, :longitude])
    end
  end
end
