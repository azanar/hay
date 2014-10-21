require 'hay/dispatcher'
require 'hay/routes'

module Hay
  class Router
    def initialize(agent)
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


