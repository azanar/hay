
module Hay
  class Consumer
    class Resolver
      def initialize(consumer)
        @consumer = consumer
      end

      def templates
        @templates ||= consumer.task_names.each do |name|
          Hay::Task.new(name).template
        end
      end

      def can_resolve?(taskish)
        templates.any? { |r|
          r.can_resolve?(taskish)
        }
      end

      def resolve(taskish)
        resolvers.templatize(taskish)
      end
    end
  end
end
