require 'hay'

require 'hay/task/exception/unknown_template_error'

module Hay
  class Task
    class Resolver
      def initialize
        @hydrators = []
        @templates = []
      end

      def can_resolve?(taskish)
      end

      def resolve
      end
    end
  end
end
