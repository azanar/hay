#require 'hay/routes'

module Hay
  class Consumer
    class Router
      def initialize(consumer, agent)
        @consumer = consumer
        @agent = agent
      end

      def push(message)
        route_klass = message.destination

        if route_klass.nil?
          Hay.logger.error "Unknown route for task #{message.destination}"
          raise "Unknown route for task #{message.destination}"
        end

        route = route_klass.new(@agent)

        route.push(message)
      end
    end
  end
end




