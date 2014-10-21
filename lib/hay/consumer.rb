require 'hay'

require 'hay/queue'
require 'hay/task/resolver'
require 'hay/task/resolvers'

module Hay
  module Consumer
    def initialize(agent)
      @queue = Hay::Queue.new(self, agent)
    end

    def ours?(task)
      task_names.include?(task.task_name)
    end

    def push(task)
      resolved_task = Hay::Task::Resolver.new(task)
      @queue.push(resolved_task)
      @queue.run
    end

    def task_names
      @task_names ||= tasks.map(&:task_name)
    end
  end
end
