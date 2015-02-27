module Hay
  class Resolver
    class Hydrator::Hash
      def initialize(catalog, taskish)
        @catalog = catalog
        @taskish = taskish
      end

      def hydrate
        puts "TASKISH #{@taskish}"
        unless @taskish['name']
          raise "I can't resolve a nameless task"
        end
        template = @catalog.find(@taskish['name'])
        if template.nil?
          raise "No task for name #{@taskish['name']}"
        end
        task = template.merge(@taskish['task'])
        task.flow = Hay::Task::Flow::Hydrator.new(@catalog, @taskish['flow'])
        task
      end
    end
  end
end
