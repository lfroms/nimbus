# frozen_string_literal: true
module Weather
  module Types
    class Icon
      attr_reader :style, :color_scheme

      def initialize(style:, color_scheme:)
        @style = style
        @color_scheme = color_scheme
      end
    end
  end
end
