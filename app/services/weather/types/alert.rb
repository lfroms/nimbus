# frozen_string_literal: true
module Weather
  module Types
    class Alert
      attr_reader :title, :time, :type, :uri

      def initialize(title:, time:, type:, uri:)
        @title = title
        @time = time
        @type = type
        @uri = uri
      end
    end
  end
end
