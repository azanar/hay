module Hay
  class Resolver
    class Cutter
      class Task
        def initialize(templatish)
          @templatish = templatish
        end

        def render
          @templatish.dup
        end
      end
    end
  end
end
