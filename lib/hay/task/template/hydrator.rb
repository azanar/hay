require 'hay'

module Hay
  class Task
    class Template
      class Hydrator
        def initialize(template)
          @templates = templates
        end

        def hydrate(params = {})
          @flows.map do |flow|
            puts "TEMPLATE #{flow.inspect}"
            i = template.inflate(params).cut.to_hay
          end
        end
      end
    end
  end
end
