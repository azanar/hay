module Hay
  class Task
    module Template
      class Hash

        def initialize(params)
          @params = params

          @name = params.fetch("name")
        end

        def render(params = {})
          merged = @params.merge(params)
          Hay::Task::Hydrators.for(merged).hydrate
        end

        Hay::Task::Templates.register(::Hash, self)
      end
    end
  end
end
