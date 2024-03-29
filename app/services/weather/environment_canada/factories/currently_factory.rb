# frozen_string_literal: true
module Weather
  module EnvironmentCanada
    module Factories
      class CurrentlyFactory < Factory
        attr :current_conditions

        def initialize(current_conditions:)
          super()
          @current_conditions = current_conditions
        end

        def create
          Types::Currently.new(
            time: time,
            summary: current_conditions.xpath('condition')&.first&.content&.presence,
            icon: icon,
            temperature: current_conditions.xpath('temperature')&.first&.content&.presence,
            feels_like: feels_like,
            wind: wind,
            dew_point: current_conditions.xpath('dewpoint')&.first&.content&.presence,
            humidity: current_conditions.xpath('relativeHumidity')&.first&.content&.presence&.to_i&.to_percent,
            pressure: pressure,
            visibility: current_conditions.xpath('visibility')&.first&.content&.presence,
            uv_index: nil
          )
        end

        private

        def time
          content = current_conditions.xpath("dateTime[@name='observation' and @zone='UTC']/timeStamp").first&.content

          return Time.zone.now.to_i if content.nil?

          Time.strptime(content, '%Y%m%d%H%M%S').to_i
        end

        def icon
          code = current_conditions.xpath('iconCode')&.first&.content&.presence
          IconFactory.new(code: code).create
        end

        def feels_like
          humidex = current_conditions.xpath('humidex')&.first&.content&.presence
          wind_chill = current_conditions.xpath('windChill')&.first&.content&.presence

          if humidex.present?
            Types::FeelsLike.new(temperature: humidex, type: Types::FeelsLikeType::HUMIDEX)
          elsif wind_chill.present?
            Types::FeelsLike.new(temperature: wind_chill, type: Types::FeelsLikeType::WIND_CHILL)
          else
            Types::FeelsLike.new(temperature: nil, type: nil)
          end
        end

        def wind
          wind_node = current_conditions.xpath('wind')&.first

          Types::Wind.new(
            speed: wind_node&.xpath('speed')&.first&.content&.presence,
            gust: wind_node&.xpath('gust')&.first&.content&.presence,
            direction: wind_node&.xpath('direction')&.first&.content&.presence,
            bearing: wind_node&.xpath('bearing')&.first&.content&.presence
          )
        end

        def pressure
          pressure_node = current_conditions.xpath('pressure')&.first

          Types::Pressure.new(
            value: pressure_node&.content&.presence,
            tendency: tendency(pressure_node),
            change: pressure_node&.get_attribute('change')&.presence
          )
        end

        def tendency(pressure_node)
          tendency = pressure_node&.get_attribute('tendency')

          return nil if tendency.nil?

          case tendency
          when 'rising'
            Types::Tendency::RISING
          when 'falling'
            Types::Tendency::FALLING
          else
            Types::Tendency::STABLE
          end
        end
      end
    end
  end
end
