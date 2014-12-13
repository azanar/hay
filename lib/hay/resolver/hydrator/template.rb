module Hay
  class Resolver
    class Hydrator
      class Template
        def initialize(resolver,template) 
          @resolver = resolver
          @template = template
        end

        # TODO: should dup here?
        def hydrate
          @template
        end
      end
    end
  end
end

