class RenameCanadaSiteToWeatherStation < ActiveRecord::Migration[6.0]
  def change
    rename_table :canada_sites, :weather_stations
  end
end
