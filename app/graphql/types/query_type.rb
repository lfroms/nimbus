# frozen_string_literal: true
module Types
  class QueryType < Types::BaseObject
    description 'All queries that can be performed.'

    field :weather,
      resolver: Resolvers::WeatherResolver,
      description: 'Returns the weather for a specific location.'
  end
end
