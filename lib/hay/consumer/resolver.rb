
module Hay
  class Consumer
    class Resolver
      def initialize(consumer)
        @consumer = consumer
      end

      def resolvers
        @resolvers ||= consumer.task_names.each do |name|
          Hay::Task
        end
      end

      def resolve(taskish)
        resolvers
      end
    end
  end
end
