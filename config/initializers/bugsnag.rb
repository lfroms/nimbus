# frozen_string_literal: true
return unless Rails.env.production?

Bugsnag.configure do |config|
  config.api_key = Rails.application.credentials.bugsnag[:api_key]
end
