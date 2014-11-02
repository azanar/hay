
module Hay
  class Consumer
    class Resolver
      def initialize(catalog)
        @catalog = catalog
      end

      def can_resolve?(taskish)
        @catalog.any? { |r|
          r.can_resolve?(taskish)
        }
      end

      def resolve(taskish)
        resolvers.templatize(taskish)
      end
    end
  end
end
