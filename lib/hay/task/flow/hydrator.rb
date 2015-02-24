module Hay
  class Task
    module Flow
      class Hydrator
        def initialize(resolver, flows)
          @resolver = resolver
          @flows = flows
        end

        def hydrate
          list = @flows.map { |flow|
            flow.inflate(@resolver)
          }

          Hay::Task::Flow::Node::List.new(list)
        end
      end
    end
  end
end
