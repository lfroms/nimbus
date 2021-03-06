# frozen_string_literal: true
module Weather
  class Base
    attr_reader :coordinate

    def initialize(coordinate:)
      @coordinate = coordinate
    end

    def location
      raise NotImplementedError, 'This method must be implemented by the child class.'
    end

    def today
      raise NotImplementedError, 'This method must be implemented by the child class.'
    end

    def currently
      raise NotImplementedError, 'This method must be implemented by the child class.'
    end

    def hourly
      raise NotImplementedError, 'This method must be implemented by the child class.'
    end

    def daily
      raise NotImplementedError, 'This method must be implemented by the child class.'
    end

    def alerts
      raise NotImplementedError, 'This method must be implemented by the child class.'
    end

    protected

    def data
      raise NotImplementedError, 'This method must be implemented by the child class.'
    end
  end
end
