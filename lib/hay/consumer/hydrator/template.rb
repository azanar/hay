module Hay
  class Task
    class Hydrator
      class Template
        def initialize(consumer,template) 
          @consumer = consumer
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

