module Hay
  class Task
    module Flow
      class Hydrator
        def initialize(catalog, flows)
          @catalog = catalog
          @flows = flows
        end

        def hydrate
          list = @flows.map { |flow|
            flow.inflate(@catalog)
          }

          Hay::Task::Flow::Node::List.new(list)
        end
      end
    end
  end
end
