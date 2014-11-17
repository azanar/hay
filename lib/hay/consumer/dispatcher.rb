require 'hay'

require 'hay/consumer/router'
require 'hay/message'

module Hay
  class Consumer
    class Dispatcher
      def initialize(consumer, agent)
        @consumer = consumer
        @agent = agent
        @router = Hay::Consumer::Router.new(@consumer, @agent)
      end

      def push(task)
        if @consumer.ours?(task)
          @consumer.push(task)
        else
          message = Hay::Message.new(task)
          @router.push(message)
        end
      end
    end
  end
end
