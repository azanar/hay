require 'hay/consumer/dispatcher'

module Hay
  module Consumer
    class Queue
      def initialize(consumer, agent)
        @queue = []
        @dispatcher = Hay::Consumer::Dispatcher.new(consumer, agent)
      end

      def push(instance)
        @queue << instance
      end

      def run
        until @queue.empty?
          instance = @queue.shift
          instance.process(@dispatcher)
        end
      end
    end
  end
end
