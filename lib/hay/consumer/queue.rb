require 'hay/consumer/dispatcher'

module Hay
  module Consumer
    class Queue
      def initialize(consumer, agent)
        @queue = []
        @dispatcher = Hay::Consumer::Dispatcher.new(consumer, agent)
      end

      def push(task)
        @queue << task
      end

      def run
        until @queue.empty?
          task = @queue.shift
          task.process(@dispatcher)
        end
      end
    end
  end
end
