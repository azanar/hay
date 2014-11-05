require 'hay/task/template/hydrator'

module Hay
  class Task
    class Resulter
      def initialize(flows, dispatcher)
        @hydrator = Hay::Task::Template::Hydrator.new(flows)
        @dispatcher = dispatcher
      end

      def inject(task)
        @dispatcher.push(task)
      end

      def submit(data)
        tasks = @hydrator.hydrate(data)
        tasks.each do |task|
          @dispatcher.push(task)
        end
      end
    end
  end
end
