# frozen_string_literal: true
module Weather
  module NationalWeatherService
    module Factories
      class AlertsFactory < Factory
        attr :alerts

        def initialize(alerts:)
          @alerts = alerts
        end

        def create
          return [] if alerts.nil?

          alerts.map do |feature|
            Types::Alert.new(
              title: feature.properties['event'] || 'Alert',
              time: time(event: feature.properties),
              type: event_type(event: feature.properties),
              url: url
            )
          end
        end

        private

        def time(event:)
          Time.iso8601(event.dig('effective'))&.to_i
        end

        def url
          'https://weather.gov'
        end

        def event_type(event:)
          Types::AlertType::WARNING
        end
      end
    end
  end
end
