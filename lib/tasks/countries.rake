# frozen_string_literal: true
namespace :countries do
  desc 'Communicates with all weather services and saves the station lists to the database'
  task sync: :environment do
    Countries::CountrySyncService.execute
  end
end
