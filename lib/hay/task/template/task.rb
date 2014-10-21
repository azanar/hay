require 'hay/task/decorator'

module Hay
  module Task
    module Template
      class Task
        def initialize(params)
          @name = params.task_name
          @payload = params.payload
          @flow = params.flow
        end

        def render(params = {})
          merged = params.merge(@payload)

          task_class = Hay::Tasks.for(@name)
          task = task_class.new(merged).to_hay

          task.flow = @flow
          task
        end

        Hay::Task::Templates.register(Hay::Task::Decorator, self)
      end
    end
  end
end

