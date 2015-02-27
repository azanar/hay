require 'hay/task'
require 'hay/task/instance'

module Hay
  class Task
    # A Task::Template isn't a Task just yet, but it is in the process of
    # being constructed to *become* a Task.
    class Template
      def initialize(instance, params = {})
        unless instance.class.include?(Hay::Task::Instance) or instance.include?(Hay::Task::Instance)
          raise
        end
        @instance = instance
        @params = params
      end

      def merge(params = {})
        self.new(@instance, @params.merge(params))
      end

      def dehydrate
        {}
      end

      def render
        Hay::Task.new(self, @instance.new(@params))
      end
    end
  end
end
