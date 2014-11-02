require 'hay/task/flow'

module Hay
  class Task
    class Hydrator
      def initialize(resolver, hash)
        @resolver = resolver
        @hash = hash
      end

      def hydrate
        task_class = resolver.resolve(@hash)
        if task_class.nil?
          raise "No task for name #{@hash['name']}"
        end
        task = task_class.new(@hash['task']).to_hay
        task.flow = Hay::Task::Flow.new(@hash['flow'])
        task
      end
    end
  end
end
