require 'hay/task/flow/node'

module Hay
  class Task
    module Flow
      module Node
        class Dehydrated
          include Flow::Node

          def inflate(catalog)
            inflator = Hay::Consumer::Catalog::Inflator.new(catalog)
            template = inflator.inflate(@template['name'])

            Hydrated.new(template)
          end

          def cut
            raise "Need to inflate me first!"
          end

          def dehydrate
            self
          end
        end
      end
    end
  end
end

