# frozen_string_literal: true
module Weather
  module EnvironmentCanada
    module Factories
      class AlertsFactory < Factory
        attr :warnings

        def initialize(warnings:)
          super()
          @warnings = warnings
        end

        def create
          return [] if warnings.nil?
          warning_events = warnings.xpath('event')

          warning_events.map do |event|
            Types::Alert.new(
              title: event.get_attribute('description')&.titlecase&.strip || 'Alert',
              time: time(event: event),
              type: event_type(event: event),
              url: url
            )
          end
        end

        private

        def time(event:)
          content = event.xpath("dateTime[@name='eventIssue' and @zone='UTC']/timeStamp").first&.content

          return Time.zone.now.to_i if content.nil?

          Time.strptime(content, '%Y%m%d%H%M%S').to_i
        end

        def url
          @warnings&.first&.get_attribute('url') || 'https://weather.gc.ca'
        end

        def event_type(event:)
          type = event.get_attribute('type').downcase

          case type
          when 'advisory'
            Types::AlertType::ADVISORY
          when 'warning'
            Types::AlertType::WARNING
          when 'watch'
            Types::AlertType::WATCH
          when 'ended'
            Types::AlertType::ENDED
          when 'statement'
            Types::AlertType::STATEMENT
          else
            Types::AlertType::WARNING
          end
        end
      end
    end
  end
end
