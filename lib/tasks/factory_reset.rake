# frozen_string_literal: true
namespace :factory_reset do
  desc 'Tools for performing factory reset actions.'

  task full: ['db:drop', 'db:create', 'db:migrate'] do
    sync_data
  end

  task partial: ['db:migrate'] do
    sync_data
  end

  def sync_data
    puts 'Syncing countries...'
    Countries::CountrySyncService.execute

    puts 'Syncing station list from Environment Canada...'
    Stations::EnvironmentCanada::StationListSyncService.execute

    puts 'Syncing station list from National Weather Service...'
    Stations::NationalWeatherService::StationListSyncService.execute
  end
end
