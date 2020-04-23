# frozen_string_literal: true
module Types
  class TendencyType < Types::BaseEnum
    value 'rising'
    value 'falling'
    value 'stable'
  end
end
