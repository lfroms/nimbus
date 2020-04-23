# frozen_string_literal: true
module Types
  class AlertTypeType < Types::BaseEnum
    value 'advisory'
    value 'warning'
    value 'watch'
    value 'ended'
    value 'statement'
  end
end
