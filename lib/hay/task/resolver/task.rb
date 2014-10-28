require 'hay/task/decorator'

module Hay
  class Task
    module Resolver
      class Task
        def initialize(task)
          @task = task
        end

        def build
          @task
        end
        Hay::Task::Resolvers.register(Hay::Task, self)
      end
    end
  end
end
