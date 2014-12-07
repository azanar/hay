require 'hay/task'

module Hay
  class Task
    # A Task::Template isn't a Task just yet, but it is in the process of
    # being constructed to *become* a Task.
    class Template
      def initialize(instance, params = {})
        unless instance.include?(Hay::Task::Instance)
          raise
        end
        @instance = instance
        @params = params
      end

      def merge(params = {})
        self.new(@instance, @params.merge(params))
      end

      def render
        @instance.new(@params)
      end
    end
  end
end
