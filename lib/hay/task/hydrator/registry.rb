module Hay
  module Task
    class Factory
      module Registry
        @@factories = {}

        def self.register(task_class)
          @@factories[task_class.task_name] = Hay::Task::Factory.new(task_class)
        end

        def self.factory_by_task_class(task_class)
          @@factories[task_class.task_name]
        end

        def self.factory_by_task_name(task_name)
          @@factories[task_name]
        end
      end
    end
  end
end
