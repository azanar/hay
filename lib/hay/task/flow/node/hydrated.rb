require 'hay/task/flow/node'

module Hay
  class Task
    module Flow
      module Node
        class Hydrated
          include Flow::Node

          def inflate(catalog)
            self
          end

          def cut
            @template.render
          end

          def dehydrate
            Hay.logger.debug("Dehydrating #{@template.inspect}")
            d = @template.dehydrate 

            Dehydrated.new(d)
          end
        end
      end
    end
  end
end
