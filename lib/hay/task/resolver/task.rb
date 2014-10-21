require 'hay/task/decorator'

module Hay
  module Task
    module Resolver
      class Task
        def initialize(task)
          @task = task
        end

        def build
          @task
        end
        Hay::Task::Resolvers.register(Hay::Task::Decorator, self)
      end
    end
  end
end
