# frozen_string_literal: true
module Weather
  module Errors
    class NoDataError < StandardError
      def initialize(msg = 'No sites were able to respond with sufficient data')
        super
      end
    end
  end
end
