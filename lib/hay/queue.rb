require 'hay/dispatcher'

module Hay
  class Queue
    def initialize(consumer, agent)
      @queue = []
      @dispatcher = Hay::Dispatcher.new(consumer, agent)
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

