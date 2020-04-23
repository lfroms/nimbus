# frozen_string_literal: true
module Types
  class FeelsLikeType < Types::BaseObject
    field :temperature, Float, null: true
    field :type, Types::FeelsLikeTypeType, null: true
  end
end
