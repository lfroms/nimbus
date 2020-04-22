# frozen_string_literal: true
module Weather
  class EnvironmentCanada < Weather::Base
    attr :coordinate, :user_coordinate

    def initialize(coordinate:, user_coordinate:)
      super
      @coordinate = coordinate
      @user_coordinate = user_coordinate
    end

    def location
      Types::Location.new(
        region_name: data.xpath('//location/name').first&.content,
        station_name: data.xpath('//currentConditions/station').first&.content,
        country: data.xpath('//location/country').first&.content,
        coordinate: @coordinate,
        distance: distance_between(@coordinate, @user_coordinate)

      )
    end

    def today
      Types::Today.new(
        high_temperature: data.xpath("//forecastGroup/forecast[period/@textForecastName='Today']//temperature").first&.content,
        low_temperature: data.xpath("//forecastGroup/forecast[period/@textForecastName='Tonight']//temperature").first&.content,
        sunrise_time: data.xpath("//riseSet/dateTime[@name='sunrise' and @zone='UTC']/timeStamp").first&.content&.to_unix,
        sunset_time: data.xpath("//riseSet/dateTime[@name='sunset' and @zone='UTC']/timeStamp").first&.content&.to_unix,
      )
    end

    def currently
      Types::Currently.new(
        time: data.xpath("//currentConditions/dateTime[@name='observation' and @zone='UTC']").first&.content&.to_unix,
        summary: data.xpath('//currentConditions/condition').first&.content,
        icon: data.xpath('//currentConditions/iconCode').first&.content,
        temperature: data.xpath('//currentConditions/temperature').first&.content,
        feels_like: feels_like,
        wind: wind,
        dew_point: data.xpath('//currentConditions/dewpoint').first&.content,
        humidity: data.xpath('//currentConditions/relativeHumidity').first&.content,
        pressure: pressure,
        visibility: data.xpath('//currentConditions/visibility').first&.content,
        uv_index: nil
      )
    end

    def hourly
    end

    def daily
    end

    def alerts
    end

    private

    def data
      @data ||= nil
    end

    def feels_like
      humidex = data.xpath('//currentConditions/humidex').first
      wind_chill = data.xpath('//currentConditions/windChill').first

      return Types::FeelsLike.new(temperature: nil, type: nil) unless humidex.present? || wind_chill.present?

      if humidex.present?
        Types::FeelsLike.new(temperature: humidex, type: Types::FeelsLikeType::HUMIDEX)
      else
        Types::FeelsLike.new(temperature: wind_chill, type: Types::FeelsLikeType::WIND_CHILL)
      end
    end

    def wind
      wind_node = data.xpath('//currentConditions/wind').first

      Types::Wind.new(
        speed: wind_node&.xpath('//speed')&.first&.content,
        gust: wind_node&.xpath('//gust')&.first&.content,
        direction: wind_node&.xpath('//direction')&.first&.content,
        bearing: wind_node&.xpath('//bearing')&.first&.content
      )
    end

    def pressure
      pressure_node = data.xpath('//currentConditions/pressure').first

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

    def distance_between(coord_1, coord_2)
      factory = RGeo::Geographic.spherical_factoriy

      first_point = factory.point(coord_1.longitude, coord_1.latitude)
      second_point = factory.point(coord_2.longitude, coord_2.latitude)

      first_point.distance(second_point)
    end
  end
end
