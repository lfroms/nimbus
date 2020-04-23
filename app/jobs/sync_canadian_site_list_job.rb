# frozen_string_literal: true
class SyncCanadianSiteListJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    Sites::EnvironmentCanada::SiteListSyncService.execute
  end
end
