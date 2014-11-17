require 'hay/task/flow/hydrator'

module Hay
  class Task
    class Resulter
      def initialize(flows, catalog, dispatcher)
        @hydrator = Hay::Task::Flow::Hydrator.new(catalog, flows)
        @dispatcher = dispatcher
      end

      def inject(task)
        @dispatcher.push(task)
      end

      def submit(data)
        tasks = @hydrator.hydrate
        tasks.each do |task|
          @dispatcher.push(task)
        end
      end
    end
  end
end
