module Hay
  class Route
    module Autowired
      def self.included(route)
        route.class_exec do
          include Hay::Route
        end
        Hay::Routes.register(route)
      end
    end

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
