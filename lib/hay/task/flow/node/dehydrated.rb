require 'hay/task/flow/node'

require 'hay/resolver/inflator'

module Hay
  class Task
    module Flow
      module Node
        class Dehydrated
          include Flow::Node

          def inflate(resolver)
            inflator = Hay::Resolver::Inflator.new(resolver)
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

