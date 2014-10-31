require 'hay'

require 'hay/consumer/queue'
require 'hay/consumer/resolver'

module Hay
  module Consumer
    def initialize(agent)
      @queue = Hay::Consumer::Queue.new(self, agent)
      @resolver = Hay::Consumer::Resolver.new(self)
    end

    attr_reader :resolver

    def ours?(task)
      @resolver.can_resolve?(task)
    end

    def push(task)
      resolved_task = @resolver.resolve(task)

      resolved_task = Hay::Task.new(task)
      @queue.push(resolved_task)
      @queue.run
    end

    def task_names
      @task_names ||= tasks.map(&:task_name)
    end
  end
end
