module Hay
  class Task
    class Hydrator
      class Hash
        def initialize(resolver, hash)
          @resolver = resolver
          @hash = hash
        end

        def hydrate
          unless @resolver.can_resolve?(@hash)
            raise
          end

          @resolver.resolve(@hash)
        end
      end
    end
  end
end
