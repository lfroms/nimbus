# frozen_string_literal: true
module Weather
  module NationalWeatherService
    module Factories
      class Factory
        def create
          raise NotImplementedError, 'This method must be implemented by the child class.'
        end
      end
    end
  end
end
