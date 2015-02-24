require 'hay/task/flow/hydrator'
require 'hay/task/template/hydrator'

module Hay
  class Task
    class Resulter
      def initialize(flows, resolver, dispatcher)
        @hydrator = Hay::Task::Flow::Hydrator.new(resolver, flows)
        @dispatcher = dispatcher
      end

      def inject(task)
        @dispatcher.push(task)
      end

      def submit(data)
        templates = @hydrator.hydrate
        task_h = Hay::Task::Template::Hydrator.new(templates)
        tasks = task_h.hydrate(data)
        tasks.each do |task|
          @dispatcher.push(task)
        end
      end
    end
  end
end
