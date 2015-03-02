require 'hay'

require 'hay/consumer/queue'
require 'hay/resolver'

module Hay
  class Consumer
    def initialize(agent)
      @queue = Hay::Consumer::Queue.new(self, agent)
      @resolver = Hay::Resolver.new
    end

    def catalog
      resolver.catalog
    end

    def ours?(task)
      false
    end

    def push(taskish)
      task = resolver.resolve(taskish)

      @queue.push(task)
      @queue.run
    end

    def resolver
      @resolver ||= Hay::Consumer::Resolver.new(self, @catalog)
    end
  end
end
