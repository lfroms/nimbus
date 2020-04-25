# frozen_string_literal: true
module Types
  class QueryType < Types::BaseObject
    description 'All queries that can be performed.'

    field :weather,
      resolver: Resolvers::WeatherResolver,
      description: 'Returns the weather for a specific location.'

    field :radar_timestamps,
      resolver: Resolvers::RadarTimestampsResolver,
      description: 'Returns timestamps for the latest radar images.'
  end
end
