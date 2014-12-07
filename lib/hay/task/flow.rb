require 'hay'
require 'hay/consumer/catalog'

module Hay
  class Task
    module Flow
      def self.new(flow)
      end
      def initialize(template)
        unless template.kind_of?(Hay::Task::Template) or template.kind_of?(Hash)
          raise
        end
        @template = template
      end

      attr_reader :template
    end
  end
end
