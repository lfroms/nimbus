# frozen_string_literal: true
module Radar
  class Base
    attr_reader :provider

    def initialize(provider:)
      @provider = provider
    end

    def self.for(provider:)
      case provider
      when Types::Provider::ENVIRONMENT_CANADA
        EnvironmentCanada::Base.new(provider: provider)
      when Types::Provider::RAINVIEWER
        Rainviewer::Base.new(provider: provider)
      end
    end

    protected

    def data
      raise NotImplementedError, 'This method must be implemented by the child class.'
    end
  end
end
