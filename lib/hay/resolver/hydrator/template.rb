module Hay
  class Resolver
    class Hydrator
      class Template
        def initialize(resolver,template) 
          @resolver = resolver
          @template = template
        end

        def hydrate
          @template.dup
        end
      end
    end
  end
end

