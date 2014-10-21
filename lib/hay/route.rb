module Hay
  module Route
    class << self
      def queue_name
        raise NotImplementedException
      end

      def included(route)
        Hay::Routes.register(route)
      end
    end

    def initialize(agent)
      @agent = agent
    end

    def tasks
      raise NotImplementedException
    end

    def push(message)
      @agent.publish(message)
    end

    def ours?(message)
      tasks.include?(message.task.class)
    end
  end
end
