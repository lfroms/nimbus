# frozen_string_literal: true
module Resolvers
  class RadarTimestampsResolver < Resolvers::Base
    type [Float], null: false

    argument :provider, Types::RadarProviderType, required: true

    def resolve(provider:)
      Radar::Base.for(provider: provider).timestamps
    end
  end
end
