require 'hay'

require 'hay/consumer/router'
require 'hay/message'

module Hay
  class Consumer
    class Injector
      def initialize(consumer)
        @consumer = consumer
        @resolver = consumer.resolver
      end

      def inject(worker)
        task = @resolver.resolve(worker)

        @consumer.push(task)
      end
    end
  end
end
