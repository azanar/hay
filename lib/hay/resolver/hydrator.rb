require 'hay/task/flow'

module Hay
  class Resolver
    class Hydrator
      def initialize(catalog, taskish)
        @catalog = catalog
        unless taskish.kind_of?(Hash)
          raise "Taskish is a kind of #{taskish.inspect}"
        end
        @taskish = taskish
      end

      def hydrate
        task_class = @catalog.find(@taskish['name'])
        if task_class.nil?
          raise "No task for name #{@taskish['name']}"
        end
        task = task_class.new(@hash['task']).to_hay
        task.flow = Hay::Task::Flow.new(@hash['flow'])
        task
      end
    end
  end
end
