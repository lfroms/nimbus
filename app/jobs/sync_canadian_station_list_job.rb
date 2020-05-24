# frozen_string_literal: true
class SyncCanadianStationListJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    Sites::EnvironmentCanada::StationListSyncService.execute
  end
end
