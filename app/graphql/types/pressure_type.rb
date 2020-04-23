# frozen_string_literal: true
module Types
  class PressureType < Types::BaseObject
    field :value, Float, null: true
    field :tendency, Types::TendencyType, null: true
    field :change, Float, null: true
  end
end
