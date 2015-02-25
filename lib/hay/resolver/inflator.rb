module Hay
  class Resolver
    class Inflator
      def initialize(resolver)
        @resolver = resolver
      end

      def inflate(taskish)
        @resolver.resolve(taskish)
      end
    end
  end
end
