#require 'hay/routes'

module Hay
  class Consumer
    class Router
      def initialize(consumer, agent)
        @consumer = consumer
        @agent = agent
      end

      def push(message)
        @agent.publish(message)
      end
    end
  end
end




