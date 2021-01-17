# frozen_string_literal: true
module Weather
  module EnvironmentCanada
    module Factories
      class IconFactory < Factory
        attr :code

        def initialize(code:)
          super()
          @code = code
        end

        def create
          Types::Icon.new(
            style: Helpers::IconMapper.icon(code: code),
            color_scheme: Helpers::ColorSchemeMapper.color_scheme(code: code)
          )
        end
      end
    end
  end
end
