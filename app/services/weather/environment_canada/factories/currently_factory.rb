# frozen_string_literal: true
module Weather
  module EnvironmentCanada
    module Factories
      class CurrentlyFactory < Factory
        attr :current_conditions

        def initialize(current_conditions:)
          @current_conditions = current_conditions
        end

        def create
          Types::Currently.new(
            time: time,
            summary: @current_conditions.xpath('//condition').first&.content,
            icon: @current_conditions.xpath('//iconCode').first&.content,
            temperature: @current_conditions.xpath('//temperature').first&.content,
            feels_like: feels_like,
            wind: wind,
            dew_point: @current_conditions.xpath('//dewpoint').first&.content,
            humidity: @current_conditions.xpath('//relativeHumidity').first&.content,
            pressure: pressure,
            visibility: @current_conditions.xpath('//visibility').first&.content,
            uv_index: nil
          )
        end

        private

        def time
          @current_conditions.xpath("//dateTime[@name='observation' and @zone='UTC']").first&.content&.to_unix
        end

        def feels_like
          humidex = @current_conditions&.xpath('//humidex')&.first&.content
          wind_chill = @current_conditions&.xpath('//windChill')&.first&.content

          if humidex.present?
            Types::FeelsLike.new(temperature: humidex, type: Types::FeelsLikeType::HUMIDEX)
          elsif wind_chill.present?
            Types::FeelsLike.new(temperature: wind_chill, type: Types::FeelsLikeType::WIND_CHILL)
          else
            Types::FeelsLike.new(temperature: nil, type: nil)
          end
        end

        def wind
          wind_node = @current_conditions&.xpath('//wind')&.first

          Types::Wind.new(
            speed: wind_node&.xpath('//speed')&.first&.content,
            gust: wind_node&.xpath('//gust')&.first&.content,
            direction: wind_node&.xpath('//direction')&.first&.content,
            bearing: wind_node&.xpath('//bearing')&.first&.content
          )
        end

        def pressure
          pressure_node = @current_conditions&.xpath('//pressure')&.first

          Types::Pressure.new(
            value: pressure_node&.content,
            tendency: tendency(pressure_node),
            change: pressure_node&.get_attribute('change')
          )
        end

        def tendency(pressure_node)
          tendency = pressure_node&.xpath('//tendency')&.first&.content

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
