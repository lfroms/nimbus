# frozen_string_literal: true
module Types
  class AlertType < Types::BaseObject
    field :title, String, null: false
    field :time, Float, null: false
    field :type, Types::AlertTypeType, null: false
    field :url, String, null: false
  end
end
