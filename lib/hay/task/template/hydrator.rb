require 'hay'

module Hay
  class Task
    class Template
      class Hydrator
        def initialize(templates)
          @templates = templates
        end

        def hydrate(params = {})
          @templates.map do |template|
            i = template.inflate(params)

            c = i.cut
          end
        end
      end
    end
  end
end
