# frozen_string_literal: true
module Weather
  module Types
    class Alert
      attr_reader :title, :time, :type, :url

      def initialize(title:, time:, type:, url:)
        @title = title
        @time = time
        @type = type
        @url = url
      end
    end
  end
end
