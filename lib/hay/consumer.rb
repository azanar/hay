require 'hay'

require 'hay/consumer/catalog'
require 'hay/consumer/queue'
require 'hay/consumer/resolver'

module Hay
  class Consumer
    # A catalog keeps track of the templates we know about
    #
    # A resolver figures out how to turn something into a task.
    #
    # 
    def initialize(agent)
      @queue = Hay::Consumer::Queue.new(self, agent)
      @catalog = Hay::Consumer::Catalog.new(self)
      #@resolvers = Hay::Consumer::Resolver::List.new(@catalog)
      #@routes = Hay::Consumer::Routes.new(self)
    end

    attr_reader :catalog

    def ours?(taskish)
      resolver.can_resolve?(taskish)
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
