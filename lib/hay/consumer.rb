require 'hay'

require 'hay/consumer/catalog'
require 'hay/consumer/queue'
require 'hay/consumer/resolver'

module Hay
  class Consumer
    def initialize(agent)
      @queue = Hay::Consumer::Queue.new(self, agent)
      @catalog = Hay::Consumer::Catalog.new(self)
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
      @resolver ||= Hay::Consumer::Resolver.new(@catalog)
    end
  end
end
