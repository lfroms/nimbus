# frozen_string_literal: true
namespace :weather do
  desc 'Communicates with all weather services and saves the station lists to the database'
  task sync_stations: :environment do
    Sites::EnvironmentCanada::SiteListSyncService.execute
  end
end
