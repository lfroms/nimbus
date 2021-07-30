# frozen_string_literal: true
namespace :weather do
  desc 'Communicates with all weather services and saves the station lists to the database'
  task sync_stations: :environment do
    Stations::EnvironmentCanada::StationListSyncService.execute
  end
end
