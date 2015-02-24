module Hay
  class Resolver
    class Cutter
      class Template
        def initialize(template)
          @template = template
        end

        def render
          @template.render
        end
      end
    end
  end
end

