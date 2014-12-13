require 'hay'

require 'hay/consumer/queue'
require 'hay/resolver'

module Hay
  class Consumer
    # A catalog keeps track of the templates we know about
    #
    # A resolver figures out how to turn something into a task.
    #
    # 
    def initialize(agent)
      @queue = Hay::Consumer::Queue.new(self, agent)
      @resolver = Hay::Resolver.new
      #@catalog = Hay::Consumer::Catalog.new(self)
    end

    attr_reader :catalog

    def ours?(taskish)
      task
    end

    def push(taskish)
      task = resolver.resolve(taskish)

      @queue.push(task)
      @queue.run
    end

    private

    def resolver
      @resolver ||= Hay::Consumer::Resolver.new(self, @catalog)
    end
  end
end
