require 'hay'

require 'hay/consumer/injector'
require 'hay/consumer/router'
require 'hay/message'

module Hay
  class Consumer
    class Dispatcher
      def initialize(consumer, agent)
        @consumer = consumer
        @router = Hay::Consumer::Router.new(@consumer, agent)
      end

      def injector
        @injector ||= Hay::Consumer::Injector.new(@consumer)
      end

      def push(task)
        if @consumer.ours?(task)
          @consumer.push(task)
        else
          message = Hay::Message.new(@consumer, task)
          @router.push(message)
        end
      end

      def inject(worker)
        Hay.logger.warn("Deprecated!")
        injector.inject(worker)
      end
    end
  end
end
