module Hay
  module Task
    module Resolver
      module Registry
        def self.resolver_for(task_class)
          Hay::Task::Resolvers.punch(task_class)
        end
      end
    end
  end
end
