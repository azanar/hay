module Hay
  module Route
    module Autowired
      def self.included(route)
        route.class_exec do
          include Hay::Route
        end
        Hay::Routes.register(route)
      end
    end

    class << self
      def queue_name
        raise NotImplementedException
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
