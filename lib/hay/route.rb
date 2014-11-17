module Hay
  class Route
    def initialize(agent)
      @agent = agent
    end

    attr_reader :tasks
    attr_reader :queue

    def tasks
      @tasks
    end

    def push(message)
      @agent.publish(message)
    end

    def ours?(message)
      tasks.include?(message.task)
    end
  end
end
